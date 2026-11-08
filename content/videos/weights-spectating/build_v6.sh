#!/usr/bin/env bash
# Gym v6 (user's story): Kenji grabs the dumbbells ALONE → walks to the bench → struggles alone →
# Yuki comes over to watch → he gets self-conscious → forced smile → she stands over him → strain + fall → hides face.
# Same 15.1 s length, same caption label, same music + SFX library as the posted version.
set -euo pipefail
cd "$(dirname "$0")"
T=$(mktemp -d)
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=30,setsar=1"
X="-c:v libx264 -preset veryfast -crf 18 -pix_fmt yuv420p -an"
seg() { ffmpeg -nostdin -v error -y -ss "$2" -t "$3" -i "$1" -vf "$V" $X "$T/$4.mp4"; }
CAP="When you grab weights that are too heavy and she starts spectating"

seg clips/n0_rack_alone.mp4       0.1  1.8  n0  # 0.00–1.80  NEW: alone at the rack, lifts them off, smug
seg final_weights-spectating.mp4  1.8  1.6  w   # 1.80–3.40  walks across the gym (no Yuki in these frames)
seg clips/n1_alone_bench.mp4      0.4  2.1  n1  # 3.40–5.50  NEW: alone on the bench, can't kick them up
seg clips/n2_she_comes.mp4        0.2  2.0  n2  # 5.50–7.50  NEW: Yuki strolls over; he freezes, gulps, puffs his chest
seg clips/n3_forced_smile.mp4     0.2  2.3  n3  # 7.50–9.80  NEW: she stands and stares; forced smile + forehead wipe
seg final_weights-spectating.mp4  10.0 3.5  f   # 9.80–13.30 she stands over him, he strains, falls
seg clips/r3_embarrassed.mp4      0.0  1.8  g   # 13.30–15.10 hides his face, she sips
for s in n0 n1 n2 n3 g; do python3 -I ../../../tools/caption.py video $T/$s.mp4 $T/${s}c.mp4 "$CAP" >/dev/null; done
printf "file '%s'\n" $T/n0c.mp4 $T/w.mp4 $T/n1c.mp4 $T/n2c.mp4 $T/n3c.mp4 $T/f.mp4 $T/gc.mp4 > $T/list.txt
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list.txt -c:v libx264 -crf 18 -pix_fmt yuv420p -an $T/video.mp4

A=audio
ffmpeg -nostdin -v error -y -i $A/sneaky-prank.mp3 -i $A/dumbbell-clank.mp3 -i $A/straw-slurp.mp3 -i $A/strain-grunt.mp3 -i $A/defeated-sigh.mp3 -i $A/dramatic-sting.mp3 -filter_complex "\
[0]atrim=0:15.1,afade=t=out:st=14.5:d=0.6,volume=0.3[m];\
[1]asplit=2[k1][k2];[k1]adelay=600|600,volume=0.7[ka];[k2]adelay=12900|12900,volume=0.6[kb];\
[2]asplit=3[s1][s2][s3];[s1]adelay=6300|6300,volume=0.6[sa];[s2]adelay=8500|8500,volume=0.6[sb];[s3]adelay=14000|14000,volume=0.7[sc];\
[3]asplit=2[g1][g2];[g1]adelay=3800|3800,volume=0.6[ga];[g2]adelay=10600|10600,volume=0.6[gb];\
[4]adelay=13450|13450,volume=0.6[si];[5]adelay=5700|5700,volume=0.5[st];\
[m][ka][kb][sa][sb][sc][ga][gb][si][st]amix=inputs=10:normalize=0:duration=first,loudnorm=I=-14:TP=-1.5:LRA=11[out]" \
  -map "[out]" -ar 44100 -c:a aac -b:a 192k $T/audio.m4a
ffmpeg -nostdin -v error -y -i $T/video.mp4 -i $T/audio.m4a -map 0:v -map 1:a -c copy -shortest -movflags +faststart final_weights-spectating_v6.mp4
rm -rf $T
echo "wrote $(pwd)/final_weights-spectating_v6.mp4"
