#!/usr/bin/env bash
# Final edit for "Yuki's skincare vs Kenji's skincare": cuts, zoom on the side-eye,
# on-screen text, music bed, timed SFX, loudness-normalised 1080x1920 export.
set -euo pipefail
cd "$(dirname "$0")"
FONT=/usr/share/fonts/opentype/inter/Inter-ExtraBold.otf
T=$(mktemp -d)
V="scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1"
X="-c:v libx264 -preset veryfast -crf 17 -pix_fmt yuv420p -an"

# 1) Segments (no text yet)
ffmpeg -nostdin -v error -y -ss 0   -t 3   -i clips/1_yuki_skincare.mp4 -vf "$V" $X $T/s1.mp4
ffmpeg -nostdin -v error -y -ss 0   -t 4   -i clips/2_kenji_splash.mp4  -vf "$V" $X $T/s2.mp4
ffmpeg -nostdin -v error -y -ss 2.5 -t 2   -i clips/3_kenji_glow.mp4    -vf "$V" $X $T/s3.mp4
# Shot 4: punch-in on Yuki's side-eye starting 0.6 s into the shot (zoom 1.0 -> 1.55 over 0.35 s)
ffmpeg -nostdin -v error -y -ss 1.0 -t 2.5 -i clips/4_punchline.mp4 -vf "$V,\
scale=w='1080*min(1.55\,1+max(0\,t-0.6)*1.6)':h='1920*min(1.55\,1+max(0\,t-0.6)*1.6)':eval=frame,\
crop=1080:1920:x='min(max(0\,iw*0.28-540)\,iw-1080)':y='min(max(0\,ih*0.42-960)\,ih-1920)'" $X $T/s4.mp4
printf "file '%s'\n" $T/s1.mp4 $T/s2.mp4 $T/s3.mp4 $T/s4.mp4 > $T/list.txt
ffmpeg -nostdin -v error -y -f concat -safe 0 -i $T/list.txt -c copy $T/joined.mp4

# 2) On-screen text
printf "Yuki's skincare :" > $T/a.txt; printf "Kenji's skincare :" > $T/b.txt
TXT="fontfile=$FONT:fontsize=78:fontcolor=white:borderw=7:bordercolor=black@0.85:x=(w-text_w)/2:y=h*0.12"
ffmpeg -nostdin -v error -y -i $T/joined.mp4 -vf "drawtext=$TXT:textfile=$T/a.txt:enable='lt(t,3)',drawtext=$TXT:textfile=$T/b.txt:enable='gte(t,3)'" $X $T/video.mp4

# 3) Synth cartoon "bloop" pop (the SFX model returned silence for this one)
ffmpeg -nostdin -v error -y -f lavfi -i "aevalsrc='0.9*sin(2*PI*(900*t-2600*t*t))*exp(-t*28)':s=44100:d=0.18" audio/sfx_pop.wav

# 4) Mix: music bed + SFX at their beats (offsets compensate for silence at the start of each SFX file)
ffmpeg -nostdin -v error -y \
  -i audio/music.mp3 -i audio/sfx_pop.wav -i audio/sfx_splash.mp3 -i audio/sfx_sparkle.mp3 -i audio/sfx_sweatdrop.mp3 \
  -filter_complex "\
[0]atrim=0:11.5,afade=t=out:st=11.0:d=0.5,volume=0.55[m];\
[1]asplit=3[p1][p2][p3];\
[p1]adelay=600|600,volume=0.6[pa];[p2]adelay=1700|1700,volume=0.6[pb];[p3]adelay=2400|2400,volume=0.6[pc];\
[2]asplit=2[w1][w2];[w1]adelay=3000|3000,volume=1.1[wa];[w2]adelay=4400|4400,volume=1.3[wb];\
[3]asplit=2[k1][k2];[k1]adelay=6470|6470,volume=5[ka];[k2]adelay=7370|7370,volume=5[kb];\
[4]adelay=9580|9580,volume=0.9[sd];\
[m][pa][pb][pc][wa][wb][ka][kb][sd]amix=inputs=9:normalize=0:duration=first,loudnorm=I=-14:TP=-1.5:LRA=11[out]" \
  -map "[out]" -ar 44100 -c:a aac -b:a 192k $T/audio.m4a

# 5) Mux
ffmpeg -nostdin -v error -y -i $T/video.mp4 -i $T/audio.m4a -c:v copy -c:a copy -shortest -movflags +faststart final.mp4
rm -rf $T
echo "wrote $(pwd)/final.mp4"
