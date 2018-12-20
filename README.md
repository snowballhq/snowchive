Before running any of these, run `bundle`

Server: `rackup -p 3000`

Script to download clips: `rake clips:playlist[USERNAME]`
e.g. `rake clips:playlist[jef]` will download and create a playlist for Jef

To stitch together all clips in a playlist:
`ffmpeg -f concat -i _ffmpegmanifest.txt -c copy _snowball.mp4`
