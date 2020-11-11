### Docker MPD intended for HTTP streaming

https://hub.docker.com/r/randomcoww/mpd/

Default configuration creates a FLAC-3 stream over HTTP on port 8000

**Images**

https://hub.docker.com/repository/docker/randomcoww/mpd

#### Sample usage

**Docker**

```bash
docker run -it --rm \
    -v music_path:/mpd/music \
    -v cache_path:/mpd/cache \
    -p 6600:6600 \
    -p 8000:8000 \
    randomcoww/mpd:0.22.1
```

**Podman**

```bash
podman run -it --rm \
    --security-opt label=disable \
    -v music_path:/mpd/music \
    -v cache_path:/mpd/cache \
    -p 6600:6600 \
    -p 8000:8000 \
    randomcoww/mpd:0.22.1
```

**Kubernetes**

https://github.com/randomcoww/terraform-infra/tree/master/services/mpd