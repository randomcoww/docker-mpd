FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends mpd && \
    rm -rf /var/lib/mpd/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    mkdir -p /mpd/playlists /mpd/cache

COPY mpd.conf /etc/mpd.conf

EXPOSE 8000 6600

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
