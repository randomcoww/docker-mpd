FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive

ENV MUSIC_DIR /mpd/music
ENV PLAYLISTS_DIR /mpd/playlists
ENV CACHE_DIR /mpd/cache

RUN \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends mpd && \
    rm -rf /var/lib/mpd/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    mkdir -p $MUSIC_DIR $PLAYLISTS_DIR $CACHE_DIR

COPY mpd.conf /etc/mpd.conf

EXPOSE 8000 6600
VOLUME $MUSIC_DIR $PLAYLISTS_DIR $CACHE_DIR

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
