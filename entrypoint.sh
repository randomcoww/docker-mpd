#!/usr/bin/env bash

while getopts ":m:p:c:" opt; do
  case "$opt" in
    m) export music=${OPTARG} ;;
    p) export playlists=${OPTARG} ;;
    c) export cache=${OPTARG} ;;
  esac
done


## expect music passed in from mount, fail otherwise (mount not available?)

[[ "$(ls -A $music)" ]] ||  exit

ln -sf /var/lib/mpd/music $music
ln -sf /var/lib/mpd/playlists $playlists
ln -sf /var/lib/mpd/cache $cache

touch $cache/{db_file,state_file,tag_cache} \
  && chmod 0777 -R $cache \
  && chown -R mpd $cache


## start

exec mpd --no-daemon --stdout --verbose /etc/mpd.conf
