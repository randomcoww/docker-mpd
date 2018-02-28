## build script based on format of official haproxy dockerfile
## https://github.com/docker-library/haproxy/blob/master/1.8/alpine/Dockerfile

FROM alpine:latest

ENV MPD_MAJOR 0.20
ENV MPD_VERSION 0.20.18

RUN set -x \
  \
  && apk add --no-cache --virtual .build-deps \
    g++ \
    make \
    boost-dev \
    ffmpeg-dev \
    faad2-dev \
    libmodplug-dev \
    expat-dev \
    libnfs-dev \
    libid3tag-dev \
    libsndfile-dev \
    sqlite-dev \
    libsamplerate-dev \
    soxr-dev \
    curl-dev \
    bzip2-dev \
    libcdio-dev \
    zlib-dev \
    flac-dev \
    libmad-dev \
    libshout-dev \
    mpg123-dev \
    opus-dev \
    libvorbis-dev \
    wavpack-dev \
    libvorbis-dev \
    lame-dev \
  \
  && mkdir -p /usr/src/mpd \
  \
## build
  && cd / \
  && wget -O mpd.tar.xz https://www.musicpd.org/download/mpd/$MPD_MAJOR/mpd-$MPD_VERSION.tar.xz \
  && tar xf mpd.tar.xz --strip-components=1 -C /usr/src/mpd \
  && rm mpd.tar.xz \
  && cd /usr/src/mpd \
  \
  && CFLAGS='-Os' CXXFLAGS='-Os' ./configure \
    --prefix=/usr/local \
    --sysconfdir=/etc \
    --disable-documentation \
    --disable-debug \
    --disable-daemon \
    --disable-rpath \
    --disable-werror \
    --disable-openal \
    --disable-oss \
    --disable-systemd-daemon \
    --disable-alsa \
    --disable-roar \
    --disable-sndio \
    --disable-haiku \
    --disable-jack \
    --disable-ao \
    --disable-pulse \
    --disable-solaris-output \
    --with-zeroconf=no \
  && make -j "$(getconf _NPROCESSORS_ONLN)" \
  && make install-exec \
  \
## cleanup
  && cd / \
  && rm -rf /usr/src \
  \
  && runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
      | tr ',' '\n' \
      | sort -u \
      | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
  )" \
  && apk add --virtual .mpd-rundeps $runDeps \
  && apk del .build-deps \
  \
## paths
  && rm -rf /usr/share/* \
  \
  && mkdir -p \
    /mpd/playlists \
    /mpd/cache \
  \
## user
  && adduser -DH mpd


EXPOSE 8000 6600

COPY mpd.conf /etc/mpd.conf

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
