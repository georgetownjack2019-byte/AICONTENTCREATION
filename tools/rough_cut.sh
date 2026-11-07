#!/usr/bin/env bash
# Rough cut: trims clips to the planned timings, adds the on-screen text, joins them,
# and exports a silent 1080x1920 preview. Add music/SFX in CapCut or in-app.
#
# Usage: tools/rough_cut.sh <shots.txt> <output.mp4>
# shots.txt: one line per shot, pipe-separated:
#   clip_path | start_seconds | duration_seconds | on-screen text
set -euo pipefail
SHOTS="$1"; OUT="$2"
FONT=/usr/share/fonts/opentype/inter/Inter-ExtraBold.otf
TMP=$(mktemp -d)
i=0
while IFS='|' read -r clip start dur text; do
  clip=$(echo "$clip" | xargs); start=$(echo "$start" | xargs); dur=$(echo "$dur" | xargs)
  text=$(echo "$text" | sed 's/^ *//;s/ *$//')
  printf '%s' "$text" > "$TMP/t$i.txt"
  ffmpeg -nostdin -v error -y -ss "$start" -t "$dur" -i "$clip" -an \
    -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,\
drawtext=fontfile=$FONT:textfile=$TMP/t$i.txt:fontsize=78:fontcolor=white:borderw=7:bordercolor=black@0.85:x=(w-text_w)/2:y=h*0.12" \
    -c:v libx264 -preset veryfast -crf 18 -pix_fmt yuv420p "$TMP/s$i.mp4"
  echo "file '$TMP/s$i.mp4'" >> "$TMP/list.txt"
  i=$((i+1))
done < <(grep -v '^\s*#' "$SHOTS" | grep -v '^\s*$')
ffmpeg -v error -y -f concat -safe 0 -i "$TMP/list.txt" -c copy "$OUT"
rm -rf "$TMP"
echo "wrote $OUT"
