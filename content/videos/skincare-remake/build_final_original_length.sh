#!/usr/bin/env bash
# Final edit, ORIGINAL LENGTH (11.87 s) for "Yuki's skincare vs Kenji's skincare": 5-step Yuki montage with step counter,
# Kenji's splash and glow, punchline with a zoom on Yuki's side-eye, music bed, timed SFX,
# loudness-normalised 1080x1920 export.
set -euo pipefail
cd "$(dirname "$0")"
FONT=/usr/share/fonts/opentype/inter/Inter-ExtraBold.otf
T=$(mktemp -d)
V="scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1"
X="-c:v libx264 -preset veryfast -crf 17 -pix_fmt yuv420p -an"
seg() { ffmpeg -nostdin -v error -y -ss "$2" -t "$3" -i "$1" -vf "$V${5:-}" $X "$T/$4.mp4"; echo "file '$T/$4.mp4'" >> $T/list.txt; }

# 1) Segments                      clip                          start  dur  name
seg clips/1a_yuki_cleanser.mp4      0.8   0.6  y1
seg clips/1b_yuki_toner.mp4         0.8   0.6  y2
seg clips/1_yuki_skincare.mp4       0.5   0.6  y3
seg clips/1d_yuki_sheetmask.mp4     1.0   0.6  y4
seg clips/1e_yuki_cream.mp4         1.0   0.6  y5
seg clips/2_kenji_splash.mp4        0     4    k1
seg clips/3_kenji_glow.mp4          2.5   2    k2
# Punchline: punch-in on Yuki's side-eye 0.6 s into the shot (zoom 1.0 -> 1.55 over 0.35 s)
seg clips/4_punchline.mp4           1.0   2.87 p1 ",\
scale=w='1080*min(1.55\,1+max(0\,t-0.6)*1.6)':h='1920*min(1.55\,1+max(0\,t-0.6)*1.6)':eval=frame,\
crop=1080:1920:x='min(max(0\,iw*0.28-540)\,iw-1080)':y='min(max(0\,ih*0.42-960)\,ih-1920)'"
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list.txt -c copy $T/joined.mp4

# 2) On-screen text: title + step counter during Yuki's montage, then Kenji's title
printf "Yuki's skincare :" > $T/yt.txt; printf "Kenji's skincare :" > $T/kt.txt
TXT="fontfile=$FONT:fontcolor=white:borderw=7:bordercolor=black@0.85:x=(w-text_w)/2"
F="drawtext=$TXT:fontsize=78:y=h*0.12:textfile=$T/yt.txt:enable='lt(t,3)'"
for n in 1 2 3 4 5; do
  printf "step %s" $n > $T/s$n.txt
  a=$(echo "($n-1)*0.6" | bc); b=$(echo "$n*0.6" | bc)
  F="$F,drawtext=$TXT:fontsize=64:y=h*0.12+100:textfile=$T/s$n.txt:enable='between(t,$a,$b)'"
done
F="$F,drawtext=$TXT:fontsize=78:y=h*0.12:textfile=$T/kt.txt:enable='gte(t,3)'"
ffmpeg -nostdin -v error -y -i $T/joined.mp4 -vf "$F" $X $T/video.mp4

# 3) Synth cartoon "bloop" pop (the SFX model returned silence for the squish)
ffmpeg -nostdin -v error -y -f lavfi -i "aevalsrc='0.9*sin(2*PI*(900*t-2600*t*t))*exp(-t*28)':s=44100:d=0.18" audio/sfx_pop.wav

# 4) Mix (SFX offsets compensate for leading silence in each file: splash 0.6 s, sparkle 0.63 s, sweat drop 0.32 s)
ffmpeg -nostdin -v error -y \
  -i audio/music16.mp3 -i audio/sfx_pop.wav -i audio/sfx_splash.mp3 -i audio/sfx_sparkle.mp3 -i audio/sfx_sweatdrop.mp3 \
  -filter_complex "\
[0]atrim=0:11.87,afade=t=out:st=11.3:d=0.57,volume=0.55[m];\
[1]asplit=5[p1][p2][p3][p4][p5];\
[p1]adelay=150|150,volume=0.6[pa];[p2]adelay=750|750,volume=0.6[pb];[p3]adelay=1350|1350,volume=0.6[pc];\
[p4]adelay=1950|1950,volume=0.6[pd];[p5]adelay=2550|2550,volume=0.6[pe];\
[2]asplit=2[w1][w2];[w1]adelay=3000|3000,volume=1.1[wa];[w2]adelay=4400|4400,volume=1.3[wb];\
[3]asplit=2[k1][k2];[k1]adelay=6470|6470,volume=5[ka];[k2]adelay=7370|7370,volume=5[kb];\
[4]adelay=9580|9580,volume=0.9[sd];\
[m][pa][pb][pc][pd][pe][wa][wb][ka][kb][sd]amix=inputs=11:normalize=0:duration=first,loudnorm=I=-14:TP=-1.5:LRA=11[out]" \
  -map "[out]" -ar 44100 -c:a aac -b:a 192k $T/audio.m4a

# 5) Mux
ffmpeg -nostdin -v error -y -i $T/video.mp4 -i $T/audio.m4a -c:v copy -c:a copy -shortest -movflags +faststart final_original_length.mp4
rm -rf $T
echo "wrote $(pwd)/final_original_length.mp4"
