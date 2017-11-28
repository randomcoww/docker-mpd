FROM alpine:latest

RUN \
  apk add --no-cache mpd && \
  mkdir -p /mpd/playlists /mpd/cache

COPY mpd.conf /etc/mpd.conf

EXPOSE 8000 6600

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
