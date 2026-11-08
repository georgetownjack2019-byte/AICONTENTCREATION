#!/usr/bin/env python3
"""Burn a clean, TikTok-native caption: black Inter SemiBold text on a white rounded label.

Usage:
  python3 -I caption.py video <in.mp4> <out.mp4> "<caption text>" [--until 3.5] [--y 0.11]
  python3 -I caption.py image <in.png|jpg> <out.jpg> "<caption text>" [--y 0.11]   # covers
--until: seconds the caption stays on screen (omit = whole video). --y: top of the label as a fraction of height.
--lines lines.json: extra timed captions, e.g. [{"start": 2.0, "end": 3.0, "text": "Why"}, ...] shown at --lines-y (default 0.72).
Emojis are dropped (the font has none); put them in the post caption instead.
"""
import argparse, os, subprocess, tempfile, textwrap
from PIL import Image, ImageDraw, ImageFont

FONT = '/usr/share/fonts/opentype/inter/Inter-SemiBold.otf'

def label(text, width, scale=1.0):
    text = ''.join(c for c in text if ord(c) < 0x2000 or c in '’‘“”…').strip()
    fs = int(width * 0.046 * scale)
    font = ImageFont.truetype(FONT, fs)
    max_w = int(width * 0.80)
    # wrap by measured width, then rebalance so lines are similar length (no orphan words)
    words, lines, cur = text.split(), [], ''
    for w in words:
        t = (cur + ' ' + w).strip()
        if font.getlength(t) <= max_w: cur = t
        else: lines.append(cur); cur = w
    lines.append(cur)
    if len(lines) > 1:
        n, best = len(lines), None
        def splits(ws, k):
            if k == 1: yield [' '.join(ws)]; return
            for i in range(1, len(ws) - k + 2):
                for rest in splits(ws[i:], k - 1): yield [' '.join(ws[:i])] + rest
        for cand in splits(words, n):
            m = max(font.getlength(l) for l in cand)
            if m <= max_w and (best is None or m < best[0]): best = (m, cand)
        if best: lines = best[1]
    pad_x, pad_y, gap = int(fs * 0.7), int(fs * 0.45), int(fs * 0.28)
    asc, desc = font.getmetrics(); lh = asc + desc
    tw = int(max(font.getlength(l) for l in lines))
    W, H = tw + 2 * pad_x, len(lines) * lh + (len(lines) - 1) * gap + 2 * pad_y
    img = Image.new('RGBA', (W + 8, H + 12), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle((4, 8, W + 4, H + 8), radius=int(fs * 0.55), fill=(0, 0, 0, 40))       # soft shadow
    d.rounded_rectangle((4, 4, W + 4, H + 4), radius=int(fs * 0.55), fill=(255, 255, 255, 245))
    y = 4 + pad_y
    for l in lines:
        d.text((4 + (W - font.getlength(l)) / 2, y), l, font=font, fill=(18, 18, 18, 255))
        y += lh + gap
    return img

def probe_wh(p):
    o = subprocess.run(['ffprobe', '-v', 'error', '-select_streams', 'v:0', '-show_entries', 'stream=width,height',
                        '-of', 'csv=p=0', p], capture_output=True, text=True).stdout.strip().split(',')
    return int(o[0]), int(o[1])

ap = argparse.ArgumentParser()
ap.add_argument('mode', choices=['video', 'image']); ap.add_argument('src'); ap.add_argument('out'); ap.add_argument('text')
ap.add_argument('--until', type=float); ap.add_argument('--lines'); ap.add_argument('--lines-y', type=float, default=0.72); ap.add_argument('--y', type=float, default=0.11); ap.add_argument('--scale', type=float, default=1.0)
a = ap.parse_args()
if a.mode == 'image':
    base = Image.open(a.src).convert('RGB'); lab = label(a.text, base.width, a.scale)
    base.paste(lab, ((base.width - lab.width) // 2, int(base.height * a.y)), lab); base.save(a.out, quality=93)
else:
    W, H = probe_wh(a.src)
    with tempfile.TemporaryDirectory() as d:
        png = os.path.join(d, 'cap.png'); label(a.text, W, a.scale).save(png)
        inputs, filt, last = ['-i', a.src, '-i', png], [], '0:v'
        en = f":enable='lt(t,{a.until})'" if a.until else ''
        filt.append(f"[{last}][1:v]overlay=(W-w)/2:H*{a.y}{en}[v0]"); last = 'v0'
        if a.lines:
            import json
            for k, ln in enumerate(json.load(open(a.lines))):
                lp = os.path.join(d, f'l{k}.png'); label(ln['text'], W, a.scale * 0.95).save(lp); inputs += ['-i', lp]
                filt.append(f"[{last}][{k + 2}:v]overlay=(W-w)/2:H*{a.lines_y}:enable='between(t,{ln['start']},{ln['end']})'[v{k + 1}]")
                last = f'v{k + 1}'
        subprocess.run(['ffmpeg', '-v', 'error', '-y', *inputs, '-filter_complex', ';'.join(filt), '-map', f'[{last}]', '-map', '0:a?',
                        '-c:v', 'libx264', '-crf', '19', '-preset', 'medium', '-c:a', 'copy', '-movflags', '+faststart', a.out], check=True)
print('wrote', a.out)
