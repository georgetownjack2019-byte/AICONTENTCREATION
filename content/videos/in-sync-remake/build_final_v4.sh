#!/usr/bin/env bash
# v4 = the approved 6 s Kling version, punched up in the edit (no new generation):
#  - no pose reset between beat 1 and 2
#  - zoom kick on the synced laugh, slow tense push-in on the synced deadpan, snap zoom on the synced gasp
#  - music drops to awkward silence (+ cricket) during the deadpan, slams back on the gasp
#  - boing on the laugh, comedic "dun" hit + pop on the gasp
set -euo pipefail
cd "$(dirname "$0")"
FONT=/usr/share/fonts/opentype/inter/Inter-ExtraBold.otf
T=$(mktemp -d)
BASE="scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1"
X="-c:v libx264 -preset veryfast -crf 17 -pix_fmt yuv420p -an"
# zoom(t) expression -> scale up then crop back to 1080x1920 around the faces (y ≈ 45%)
Z() { echo "$BASE,scale=w='1080*($1)':h='1920*($1)':eval=frame,crop=1080:1920:x='(iw-1080)/2':y='min(max(0\,ih*0.45-960)\,ih-1920)'"; }

# Beat 1 (0.0–2.0): synced gesture + laugh; quick zoom kick when the laugh hits (~0.45 s)
ffmpeg -nostdin -v error -y -ss 0 -t 2.0 -i clips/1_think_laugh.mp4 \
  -vf "$(Z "1+0.12*min(1\,max(0\,(t-0.45)/0.12))")" $X $T/a.mp4
# Beat 2 (2.0–4.15): synced deadpan; start after the pose reset, slow tense push-in 1.0 -> 1.16
ffmpeg -nostdin -v error -y -ss 0.85 -t 2.15 -i clips/2_deadpan.mp4 \
  -vf "$(Z "1+0.16*t/2.15")" $X $T/b.mp4
# Beat 3 (4.15–6.15): synced gasp; snap zoom to 1.25, settle to 1.06
ffmpeg -nostdin -v error -y -ss 1.0 -t 2.0 -i clips/3_gasp_laugh.mp4 \
  -vf "$(Z "1.06+0.19*exp(-t*3.5)")" $X $T/c.mp4
printf "file '%s'\n" $T/a.mp4 $T/b.mp4 $T/c.mp4 > $T/list.txt
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list.txt -c copy $T/joined.mp4

# Hook text (original wording), same style as the approved version
printf "when you and your girl are" > $T/l1.txt
printf "with each other too much now" > $T/l2.txt
printf "everything you do is in sync" > $T/l3.txt
TX="fontfile=$FONT:fontsize=62:fontcolor=white:borderw=6:bordercolor=black@0.85:x=(w-text_w)/2"
ffmpeg -nostdin -v error -y -i $T/joined.mp4 -vf "drawtext=$TX:textfile=$T/l1.txt:y=250,drawtext=$TX:textfile=$T/l2.txt:y=330,drawtext=$TX:textfile=$T/l3.txt:y=410" $X $T/video.mp4

# SFX (synthesised): cricket chirp, comedic low "dun" hit, pop
ffmpeg -nostdin -v error -y -f lavfi -i "aevalsrc='0.35*sin(2*PI*4300*t)*(0.5+0.5*sin(2*PI*30*t))*lt(mod(t\,0.22)\,0.12)*exp(-t*1.5)':s=44100:d=0.5" $T/cricket.wav
ffmpeg -nostdin -v error -y -f lavfi -i "aevalsrc='0.9*sin(2*PI*(130*t-40*t*t))*exp(-t*6)+0.3*sin(2*PI*260*t)*exp(-t*9)':s=44100:d=0.6" $T/dun.wav
ffmpeg -nostdin -v error -y -f lavfi -i "aevalsrc='0.9*sin(2*PI*(900*t-2600*t*t))*exp(-t*28)':s=44100:d=0.18" $T/pop.wav

# Mix: music plays 0–2.0, silent 2.0–4.15 (awkward pause), back from 4.15
ffmpeg -nostdin -v error -y -i audio/music.mp3 -i audio/sfx_boing.wav -i $T/cricket.wav -i $T/dun.wav -i $T/pop.wav -filter_complex "\
[0]atrim=0:6.15,volume='if(between(t\,2.0\,4.15)\,0\,0.6)':eval=frame,afade=t=out:st=5.7:d=0.45[m];\
[1]adelay=500|500[bo];\
[2]asplit=2[c1][c2];[c1]adelay=2700|2700[ca];[c2]adelay=3500|3500,volume=0.8[cb];\
[3]adelay=4150|4150,volume=1.1[du];[4]adelay=4200|4200,volume=0.7[po];\
[m][bo][ca][cb][du][po]amix=inputs=6:normalize=0:duration=first,loudnorm=I=-14:TP=-1.5:LRA=11[out]" \
  -map "[out]" -ar 44100 -c:a aac -b:a 192k $T/audio.m4a
ffmpeg -nostdin -v error -y -i $T/video.mp4 -i $T/audio.m4a -map 0:v -map 1:a -c copy -shortest -movflags +faststart in-sync_FINAL_v4.mp4
rm -rf $T
echo "wrote $(pwd)/in-sync_FINAL_v4.mp4"
