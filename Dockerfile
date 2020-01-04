FROM alpine:edge

RUN set -x \
  \
  && apk add --no-cache \
    mpd

COPY mpd.conf /etc/mpd.conf
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
