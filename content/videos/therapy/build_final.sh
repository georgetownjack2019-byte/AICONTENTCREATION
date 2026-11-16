#!/usr/bin/env bash
# "the therapy" remake: 7.10 s, the original's cuts (1.63 · 3.03 · 4.33 · 5.57), label captions,
# SFX only (NO music: the user adds the song in the app).
set -euo pipefail
cd "$(dirname "$0")"
T=$(mktemp -d)
X="-c:v libx264 -preset veryfast -crf 17 -pix_fmt yuv420p -an -r 30"
FIT="scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1"
# still with a slow push-in (zoom 1.00 -> 1.0+Z over the shot)
still() { ffmpeg -nostdin -v error -y -loop 1 -t "$2" -i "$1" -vf "$FIT,scale=w='1080*(1+$3*t/$2)':h='1920*(1+$3*t/$2)':eval=frame,crop=1080:1920,fps=30" $X "$T/$4.mp4"; }
clip()  { ffmpeg -nostdin -v error -y -ss "$2" -t "$3" -i "$1" -vf "$FIT,fps=30" $X "$T/$4.mp4"; }

still stills/1_sad.png      1.63 0.06 s1   # 0.00–1.63 sad on the sofa, rain cloud
still stills/2_nails.png    1.40 0.10 s2   # 1.63–3.03 nail salon
clip  clips/3_matcha.mp4    0.3  1.30 s3   # 3.03–4.33 walks out with the giant matcha
clip  clips/4_shopping.mp4  0.3  1.24 s4   # 4.33–5.57 shopping street
still stills/5_spa.png      1.53 0.08 s5   # 5.57–7.10 spa, blissful (loop back to the sad start)
printf "file '%s'\n" $T/s1.mp4 $T/s2.mp4 $T/s3.mp4 $T/s4.mp4 $T/s5.mp4 > $T/list.txt
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list.txt -c copy $T/joined.mp4

# captions: same words as the original, clean label (tools/caption.py)
ffmpeg -nostdin -v error -y -i $T/joined.mp4 -t 1.63 $X $T/a_raw.mp4
python3 -I ../../../tools/caption.py video $T/a_raw.mp4 $T/a.mp4 "i need to go to therapy" >/dev/null
ffmpeg -nostdin -v error -y -ss 1.63 -i $T/joined.mp4 $X $T/b_raw.mp4
python3 -I ../../../tools/caption.py video $T/b_raw.mp4 $T/b.mp4 "the therapy:" >/dev/null
printf "file '%s'\n" $T/a.mp4 $T/b.mp4 > $T/list2.txt
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list2.txt -c:v libx264 -crf 17 -pix_fmt yuv420p -an $T/video.mp4

# SFX only: sad trombone-ish "wah" on the cloud, sparkle "ding" on each therapy cut, slurp, bag rustle
S=../../../assets/sfx
ffmpeg -nostdin -v error -y -f lavfi -i "aevalsrc='0.5*sin(2*PI*(330-120*t)*t)*exp(-t*2.2)':s=44100:d=1.2" $T/wah.wav
# sad violin/piano ONLY under the intro (0–1.63 s); the user adds happy music in-app for the therapy part
ffmpeg -nostdin -v error -y -f lavfi -i "anullsrc=r=44100:cl=stereo" -i $T/wah.wav -i $S/magic-sparkle.mp3 -i $S/straw-slurp.mp3 -i $S/napkin-rustle.mp3 -i $S/happy-hum.mp3 -i audio/sad_intro.mp3 -filter_complex "\
[6]atrim=1.70:3.33,asetpts=PTS-STARTPTS,afade=t=in:d=0.05,afade=t=out:st=1.45:d=0.18,volume=1.6,aformat=sample_rates=44100:channel_layouts=stereo[sad];\
[0]atrim=0:7.1[base];[base][sad]amix=inputs=2:normalize=0:duration=first[m];[1]adelay=200|200,volume=0.35[w];\
[2]asplit=4[d1][d2][d3][d4];[d1]adelay=1000|1000,volume=0.6[a1];[d2]adelay=2400|2400,volume=0.5[a2];[d3]adelay=3700|3700,volume=0.5[a3];[d4]adelay=4940|4940,volume=0.6[a4];\
[3]adelay=3250|3250,volume=0.6[sl];[4]adelay=4450|4450,volume=0.5[rs];[5]adelay=5700|5700,volume=0.6[hm];\
[m][w][a1][a2][a3][a4][sl][rs][hm]amix=inputs=9:normalize=0:duration=first,loudnorm=I=-14:TP=-1.5:LRA=11[out]" \
  -map "[out]" -ar 44100 -c:a aac -b:a 192k $T/audio.m4a
ffmpeg -nostdin -v error -y -i $T/video.mp4 -i $T/audio.m4a -map 0:v -map 1:a -c copy -shortest -movflags +faststart therapy_FINAL_SFX-ONLY.mp4
rm -rf $T
echo "wrote $(pwd)/therapy_FINAL_SFX-ONLY.mp4"
