### Docker MPD intended for HTTP streaming

https://hub.docker.com/r/randomcoww/mpd/

Default configuration creates a FLAC-3 stream over HTTP on port 8000

#### Sample usage

##### Docker run:

    docker run -it --rm \
    -v /music_path:/mpd/music \
    -v /cache_path:/mpd/cache \
    -v /playlists_path:/mpd/playlists \
    -p 6600:6600 -p 8000:8000 \
    randomcoww/mpd:latest

##### Kubernetes:

https://github.com/randomcoww/environment-config/blob/master/manifests_extra/mpd
