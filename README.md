### Docker MPD intended for HTTP streaming

https://hub.docker.com/r/randomcoww/mpd/

Default configuration creates a FLAC-3 stream over HTTP on port 8000

#### Sample usage

Docker run: 

    docker run -it --rm \
    -v /music_path:/mpd/music \
    -v /cache_path:/mpd/cache \
    -v /playlists_path:/mpd/playlists \
    -p 6600:6600 -p 8000:8000 \
    randomcoww/mpd:latest

Kubernetes:

https://github.com/randomcoww/environment-config/blob/master/manifests_extra/mpd

#### Two types of images built:

##### Date tagged images:
  
Alpine with default MPD package

##### *-build images:

Built latest from source and omits a number of local playback options:

    Database plugins:
     simple

    Storage plugins:
     local nfs curl

    Decoders plugins:
     [mad] mp3 mp2
     [mpg123] mp3
     [vorbis] ogg oga
     [oggflac] ogg oga
     [flac] flac
     [opus] opus ogg oga
     [sndfile] wav aiff aif au snd paf iff svx sf voc w64 pvf xi htk caf sd2
     [dsdiff] dff
     [dsf] dsf
     [faad] aac
     [wavpack] wv
     [modplug] 669 amf ams dbm dfm dsm far it med mdl mod mtm mt2 okt s3m stm ult umx xm
     [ffmpeg] 16sv 3g2 3gp 4xm 8svx aa3 aac ac3 adx afc aif aifc aiff al alaw amr anim apc ape asf atrac au aud avi avm2 avs bap bfi c93 cak cin cmv cpk daud dct divx dts dv dvd dxa eac3 film flac flc fli fll flx flv g726 gsm gxf iss m1v m2v m2t m2ts m4a m4b m4v mad mj2 mjpeg mjpg mka mkv mlp mm mmf mov mp+ mp1 mp2 mp3 mp4 mpc mpeg mpg mpga mpp mpu mve mvi mxf nc nsv nut nuv oga ogm ogv ogx oma ogg omg opus psp pva qcp qt r3d ra ram rl2 rm rmvb roq rpl rvc shn smk snd sol son spx str swf tak tgi tgq tgv thp ts tsp tta xa xvid uv uv2 vb vid vob voc vp6 vmd wav webm wma wmv wsaud wsvga wv wve
     [pcm]

    Filters:
     libsamplerate soxr

    Tag plugins:
     id3tag

    Output plugins:
     shout null fifo httpd recorder

    Encoder plugins:
     null vorbis opus lame wave flac

    Archive plugins:
     [bz2] bz2
     [iso] iso

    Input plugins:
     file archive curl ffmpeg nfs

    Playlist plugins:
     extm3u m3u pls xspf asx rss flac cue embcue

    Protocols:
     file:// http:// https:// gopher:// rtp:// rtsp:// rtmp:// rtmpt:// rtmps:// nfs://

    Other features:
     epoll iconv inotify ipv6 tcp un
