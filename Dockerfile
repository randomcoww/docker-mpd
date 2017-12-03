FROM alpine:latest

RUN set -x \
  \
  && apk add --no-cache mpd \
  \
  && mkdir -p \
    /mpd/playlists \
    /mpd/cache

EXPOSE 8000 6600

COPY mpd.conf /etc/mpd.conf

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
