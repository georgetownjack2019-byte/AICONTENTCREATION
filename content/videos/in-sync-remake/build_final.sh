#!/usr/bin/env bash
# Final edit: "everything you do is in sync" (Kenji & Yuki). Cuts to the original's ~6 s timing,
# burns in the original hook text, adds a music bed and a "boing" on each matching move.
set -euo pipefail
cd "$(dirname "$0")"
FONT=/usr/share/fonts/opentype/inter/Inter-ExtraBold.otf
T=$(mktemp -d)
V="scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1"
X="-c:v libx264 -preset veryfast -crf 17 -pix_fmt yuv420p -an"
seg() { ffmpeg -nostdin -v error -y -ss "$2" -t "$3" -i "$1" -vf "$V" $X "$T/$4.mp4"; echo "file '$T/$4.mp4'" >> $T/list.txt; }
#   clip                         start dur  name       (global time)
seg clips/1_think_laugh.mp4      0     1.9  a          # 0.0–1.9  thumb gesture + synced laugh
seg clips/2_deadpan.mp4          0.9   1.7  b          # 1.9–3.6  both lean back, same deadpan
seg clips/3_gasp_laugh.mp4       1.0   2.0  c          # 3.6–5.6  synced gasp → nudge → crack up
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list.txt -c copy $T/joined.mp4

# Hook text (original wording), 3 centred lines in the roof area
printf "when you and your girl are" > $T/l1.txt
printf "with each other too much now" > $T/l2.txt
printf "everything you do is in sync" > $T/l3.txt
TX="fontfile=$FONT:fontsize=62:fontcolor=white:borderw=6:bordercolor=black@0.85:x=(w-text_w)/2"
ffmpeg -nostdin -v error -y -i $T/joined.mp4 -vf "drawtext=$TX:textfile=$T/l1.txt:y=250,drawtext=$TX:textfile=$T/l2.txt:y=330,drawtext=$TX:textfile=$T/l3.txt:y=410" $X $T/video.mp4

# Audio: music bed + boing on the three synced moves
ffmpeg -nostdin -v error -y -i audio/music.mp3 -i audio/sfx_boing.wav -filter_complex "\
[0]atrim=0:5.6,afade=t=out:st=5.1:d=0.5,volume=0.6[m];\
[1]asplit=3[b1][b2][b3];[b1]adelay=550|550[x1];[b2]adelay=2000|2000[x2];[b3]adelay=3650|3650[x3];\
[m][x1][x2][x3]amix=inputs=4:normalize=0:duration=first,loudnorm=I=-14:TP=-1.5:LRA=11[out]" \
  -map "[out]" -ar 44100 -c:a aac -b:a 192k $T/audio.m4a
ffmpeg -nostdin -v error -y -i $T/video.mp4 -i $T/audio.m4a -c copy -shortest -movflags +faststart final.mp4
rm -rf $T
echo "wrote $(pwd)/final.mp4"
