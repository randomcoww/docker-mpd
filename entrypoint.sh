#!/usr/bin/env bash


## expect music passed in from mount, fail otherwise (mount not available?)

[[ "$(ls -A $MUSIC_DIR)" ]] ||  exit

touch $CACHE_DIR/{tag_cache,state,sticker.sql} \
  && chmod -R 0777 $CACHE_DIR \
  && chown -R mpd $CACHE_DIR


## start

exec mpd --no-daemon --stdout --verbose /etc/mpd.conf "$@"
