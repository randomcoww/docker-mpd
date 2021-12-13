### Docker MPD intended for HTTP streaming

https://hub.docker.com/r/randomcoww/mpd/

Default configuration creates a FLAC-3 stream over HTTP on port 8000

**Images**

https://hub.docker.com/repository/docker/randomcoww/mpd

#### Sample usage

```bash
podman run -it --rm \
    --security-opt label=disable \
    -v music_path:/mpd/music \
    -v cache_path:/mpd/cache \
    -p 6600:6600 \
    -p 8000:8000 \
    randomcoww/mpd:0.22.1
```

### Image build

```
mkdir -p build
export TMPDIR=$(pwd)/build

VERSION=0.23
PATCH=5

podman build \
  --build-arg VERSION=$VERSION \
  --build-arg PATCH=$PATCH \
  -f Dockerfile \
  -t ghcr.io/randomcoww/mpd:$VERSION.$PATCH
```

```
podman push ghcr.io/randomcoww/mpd:$VERSION.$PATCH
```