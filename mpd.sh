#!/usr/bin/env bash
## based on https://github.com/jfrazelle/dockerfiles/blob/master/mpd/mpd.sh

dir="/var/lib/mpd"

## expect shared music mount. stop unless there is something there
[[ -d $dir/music ]] || exit
[[ "$(ls -A $dir/music)" ]] ||  exit

mkdir -p $dir/cache \
	&& touch $dir/cache/{db_file,state_file,tag_cache} \
	&& chmod 0777 -R $dir/cache \
	&& chown -R mpd $dir/cache

exec mpd --no-daemon --stdout --verbose /etc/mpd.conf "$@"
