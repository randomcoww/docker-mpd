FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends mpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    rm -rf /var/lib/mpd/*

COPY mpd.conf /etc/mpd.conf

EXPOSE 8000 6600

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
