#!/bin/sh
set -e

mkdir -p /mpd/cache
touch \
  /mpd/cache/tag_cache \
  /mpd/cache/state \
  /mpd/cache/sticker.sql
chown -R mpd /mpd/cache

## start
exec mpd --no-daemon --stdout /etc/mpd.conf "$@"