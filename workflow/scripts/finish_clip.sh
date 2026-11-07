#!/usr/bin/env bash
# Usage: finish_clip.sh <video_url_or_path> <out.mp4> "<hook text line 1>" ["<line 2>"]
# Downloads a clip, burns the on-screen hook (first 3.5 s, top-centre), writes a QC contact sheet next to out.
set -euo pipefail
SRC="$1"; OUT="$2"; L1="$3"; L2="${4:-}"
FONT=/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf
TMP=$(mktemp -d)
if [[ "$SRC" == http* ]]; then curl -sS -o "$TMP/raw.mp4" "$SRC"; else cp "$SRC" "$TMP/raw.mp4"; fi
# Burned text is ASCII-only (the font has no emoji); emojis belong in the caption.
L1=$(printf '%s' "$L1" | LC_ALL=C tr -cd '\11\12\15\40-\176' | sed 's/ *$//')
L2=$(printf '%s' "$L2" | LC_ALL=C tr -cd '\11\12\15\40-\176' | sed 's/ *$//')
W=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$TMP/raw.mp4")
H=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$TMP/raw.mp4")
MAXLEN=$(( ${#L1} > ${#L2} ? ${#L1} : ${#L2} ))
# Fit the longest line into ~90% of the width (bold sans averages ~0.55 em per char), cap at H/26.
FS=$(awk -v w="$W" -v h="$H" -v n="$MAXLEN" 'BEGIN{a=int(0.9*w/(0.55*n)); b=int(h/26); print (a<b?a:b)}')
esc() { printf '%s' "$1" | sed -e "s/\\\\/\\\\\\\\/g" -e "s/:/\\\\:/g" -e "s/'/\\\\'/g" -e "s/%/\\\\%/g"; }
printf '%s' "$L1" > "$TMP/l1.txt"; printf '%s' "$L2" > "$TMP/l2.txt"
# Text is read from files so apostrophes/colons need no escaping.
F="drawtext=fontfile=$FONT:textfile=$TMP/l1.txt:fontsize=$FS:fontcolor=white:borderw=5:bordercolor=black:x=(w-text_w)/2:y=h*0.12:enable='lt(t,3.5)'"
if [[ -n "$L2" ]]; then
  F="$F,drawtext=fontfile=$FONT:textfile=$TMP/l2.txt:fontsize=$FS:fontcolor=white:borderw=5:bordercolor=black:x=(w-text_w)/2:y=h*0.12+$FS*1.3:enable='lt(t,3.5)'"
fi
ffmpeg -v error -y -i "$TMP/raw.mp4" -vf "$F" -c:v libx264 -crf 20 -preset medium -c:a copy -movflags +faststart "$OUT"
ffmpeg -v error -y -i "$OUT" -vf "fps=1,scale=270:-1,tile=4x2" -frames:v 1 "${OUT%.mp4}_qc.png"
rm -rf "$TMP"
echo "wrote $OUT and ${OUT%.mp4}_qc.png"
