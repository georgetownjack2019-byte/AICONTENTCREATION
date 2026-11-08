#!/usr/bin/env bash
# Gym v4: the posted v3 cut with three self-conscious Kenji moments added (same 15.1 s length,
# same caption label, same music and SFX library as the other session's version).
set -euo pipefail
cd "$(dirname "$0")"
T=$(mktemp -d)
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=30,setsar=1"
X="-c:v libx264 -preset veryfast -crf 18 -pix_fmt yuv420p -an"
seg() { ffmpeg -nostdin -v error -y -ss "$2" -t "$3" -i "$1" -vf "$V" $X "$T/$4.mp4"; }
CAP="When you grab weights that are too heavy and she starts spectating"

# v3 footage already has the caption burned in; new clips get the same label (tools/caption.py, y=0.11)
seg final_weights-spectating.mp4 0.0  3.0  a   # 0.00–3.00  grabs dumbbells, waddles
seg final_weights-spectating.mp4 4.3  1.0  b   # 3.00–4.00  Yuki looks over, sips
seg clips/r1_notices.mp4         0.5  2.25 c0  # 4.00–6.25  NEW: he notices, gulps, puffs his chest
seg final_weights-spectating.mp4 5.5  1.5  d   # 6.25–7.75  sits next to her, can't lift
seg clips/r2_fake_casual.mp4     0.0  2.0  e0  # 7.75–9.75  NEW: forced smile + fake-casual forehead wipe
seg final_weights-spectating.mp4 10.0 3.55 f   # 9.75–13.30 she stands over him, he strains, falls
seg clips/r3_embarrassed.mp4     0.0  1.8  g0  # 13.30–15.10 NEW: hides his face, she sips
for s in c0 e0 g0; do python3 -I ../../../tools/caption.py video $T/$s.mp4 $T/${s%0}.mp4 "$CAP" >/dev/null; done
printf "file '%s'\n" $T/a.mp4 $T/b.mp4 $T/c.mp4 $T/d.mp4 $T/e.mp4 $T/f.mp4 $T/g.mp4 > $T/list.txt
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list.txt -c:v libx264 -crf 18 -pix_fmt yuv420p -an $T/video.mp4

# Sound: same music bed + SFX as v3, retimed, plus a comedic sting when he notices her
A=audio
ffmpeg -nostdin -v error -y -i $A/sneaky-prank.mp3 -i $A/dumbbell-clank.mp3 -i $A/straw-slurp.mp3 -i $A/strain-grunt.mp3 -i $A/defeated-sigh.mp3 -i $A/dramatic-sting.mp3 -filter_complex "\
[0]atrim=0:15.1,afade=t=out:st=14.5:d=0.6,volume=0.3[m];\
[1]asplit=2[k1][k2];[k1]adelay=300|300,volume=0.7[ka];[k2]adelay=12900|12900,volume=0.6[kb];\
[2]asplit=3[s1][s2][s3];[s1]adelay=3200|3200,volume=0.6[sa];[s2]adelay=8300|8300,volume=0.6[sb];[s3]adelay=14000|14000,volume=0.7[sc];\
[3]adelay=10600|10600,volume=0.6[gr];[4]adelay=13450|13450,volume=0.6[si];[5]adelay=4150|4150,volume=0.5[st];\
[m][ka][kb][sa][sb][sc][gr][si][st]amix=inputs=9:normalize=0:duration=first,loudnorm=I=-14:TP=-1.5:LRA=11[out]" \
  -map "[out]" -ar 44100 -c:a aac -b:a 192k $T/audio.m4a
ffmpeg -nostdin -v error -y -i $T/video.mp4 -i $T/audio.m4a -map 0:v -map 1:a -c copy -shortest -movflags +faststart final_weights-spectating_v4.mp4
rm -rf $T
echo "wrote $(pwd)/final_weights-spectating_v4.mp4"
