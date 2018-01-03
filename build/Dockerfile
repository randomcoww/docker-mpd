## build script based on format of official haproxy dockerfile
## https://github.com/docker-library/haproxy/blob/master/1.8/alpine/Dockerfile

FROM alpine:3.7

ENV MPD_VERSION 0.20.14

RUN set -x \
  \
  && apk add --no-cache --virtual .build-deps \
    xz \
    tar \
    g++ \
    boost-dev \
    make \
    ffmpeg-dev \
    libmpdclient-dev \
    libid3tag-dev \
    sqlite-dev \
    libsamplerate-dev \
    soxr-dev \
    curl-dev \
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
## build log4cplus
  && cd / \
  && wget -O mpd.tar.xz https://www.musicpd.org/download/mpd/0.20/mpd-$MPD_VERSION.tar.xz \
  && xz -d mpd.tar.xz \
  && tar xf mpd.tar --strip-components=1 -C /usr/src/mpd \
  && rm mpd.tar \
  && cd /usr/src/mpd \
  \
  && CFLAGS='-Os' CXXFLAGS='-Os' ./configure \
    --build=$CBUILD \
    --host=$CHOST \
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
    --disable-sidplay \
    --disable-cdio-paranoia \
    --disable-mms \
  && make -j "$(getconf _NPROCESSORS_ONLN)" \
  && make install \
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
  && apk add --virtual .kea-rundeps $runDeps \
  && apk del .build-deps \
  \
## paths
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
