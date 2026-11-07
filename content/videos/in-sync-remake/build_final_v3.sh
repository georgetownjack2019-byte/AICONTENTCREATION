#!/usr/bin/env bash
# v3, the method from the user's posted videos: one still per beat → one Wan 2.7 clip per beat,
# cut to the original's exact beat timing (6.15 s), TikTok-native caption label, music + SFX.
set -euo pipefail
cd "$(dirname "$0")"
T=$(mktemp -d)
V="scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1"
X="-c:v libx264 -preset veryfast -crf 17 -pix_fmt yuv420p -an -r 30"
# seg <clip> <start> <source dur> <speed> <name>   (output length = source dur / speed)
seg() { ffmpeg -nostdin -v error -y -ss "$2" -t "$3" -i "$1" -vf "$V,setpts=PTS/$4,fps=30" $X "$T/$5.mp4"; echo "file '$T/$5.mp4'" >> $T/list.txt; }
#   clip            start src  speed  name     original beat
seg clips_v3/b1.mp4  0.4  1.2  1      b1       # 0.0–1.2   chin-in-paw, his thumb gesture
seg clips_v3/b2.mp4  0.4  2.6  1.857  b2       # 1.2–2.6   both fold forward laughing → fist bump
seg clips_v3/b3.mp4  0.3  2.2  1      b3       # 2.6–4.8   both lean back, calm
seg clips_v3/b4.mp4  0    2.02 1.496  b4       # 4.8–6.15  paws over mouths → he shoves her, she bends away
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list.txt -c copy $T/joined.mp4

# Caption: original wording, clean TikTok-style label (black Inter SemiBold on white rounded box)
python3 -I ../../../tools/caption.py video $T/joined.mp4 $T/video.mp4 \
  "when you and your girl are with each other too much now everything you do is in sync" --y 0.11

# Audio: music bed + boing on each synced move
ffmpeg -nostdin -v error -y -i audio/music.mp3 -i audio/sfx_boing.wav -filter_complex "\
[0]atrim=0:6.15,afade=t=out:st=5.65:d=0.5,volume=0.6[m];\
[1]asplit=3[b1][b2][b3];[b1]adelay=1300|1300[x1];[b2]adelay=2650|2650[x2];[b3]adelay=4850|4850[x3];\
[m][x1][x2][x3]amix=inputs=4:normalize=0:duration=first,loudnorm=I=-14:TP=-1.5:LRA=11[out]" \
  -map "[out]" -ar 44100 -c:a aac -b:a 192k $T/audio.m4a
ffmpeg -nostdin -v error -y -i $T/video.mp4 -i $T/audio.m4a -map 0:v -map 1:a -c copy -shortest -movflags +faststart in-sync_FINAL_v3.mp4
rm -rf $T
echo "wrote $(pwd)/in-sync_FINAL_v3.mp4"
