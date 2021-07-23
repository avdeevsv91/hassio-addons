# RTSP to RTMP Pusher

[![Donate](https://img.shields.io/badge/donate-Yandex-red.svg)](https://money.yandex.ru/to/4100110221014297)

Pushing the RTSP stream to the RTMP server.

## Configuration

```yaml
streams:
  - source: "rtsp://<source_address>"
    target: "rtmp://<target_address>"
    video: "<video_codec>"
    audio: "<audio_codec>"
    options: "<ffmpeg_options>"
```

where:

- **<source_address>** - Address of the RTSP stream;
- **<target_address>** - Address of the RTMP server;
- **<video_codec>** - Set the [video codec](https://ffmpeg.org/ffmpeg-codecs.html#Video-Encoders) (default: `copy`);
- **<audio_codec>** - Set the [audio codec](https://ffmpeg.org/ffmpeg-codecs.html#Audio-Encoders) (default: `copy`);
- **<ffmpeg_options>** - Additional options for [ffmpeg](https://ffmpeg.org/ffmpeg.html#Options).

You can specify several different streams, each with their own parameters.

## Examples

```yaml
streams:
  - source: "rtsp://192.168.1.10/stream1"
    target: "rtmp://a.rtmp.youtube.com/live2/0000-0000-0000-0000"
    options: "-copy_unknown"
  - source: "rtsp://192.168.1.15/stream2"
    target: "rtmp://a.rtmp.youtube.com/live2/1111-1111-1111-1111"
    audio: "aac"
```
