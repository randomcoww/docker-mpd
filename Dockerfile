FROM alpine:edge

RUN set -x \
  \
  && apk add --no-cache mpd

EXPOSE 8000 6600

COPY mpd.conf /etc/mpd.conf

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
