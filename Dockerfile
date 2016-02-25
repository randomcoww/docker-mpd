FROM debian:jessie

# Install mpd
RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends mpd \
                $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* \
    rm -rf /var/lib/mpd/music

COPY mpd.sh /usr/bin/
COPY mpd.conf /etc/mpd.conf

## expect NFS at music, container vol at cache
VOLUME ["/var/lib/mpd/music", "/var/lib/mpd/cache"]

EXPOSE 8000 8001 6600

ENTRYPOINT ["mpd.sh"]
