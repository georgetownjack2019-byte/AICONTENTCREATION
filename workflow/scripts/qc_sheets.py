#!/usr/bin/env python3
"""Dense QC contact sheets so short AI glitches (0.2-0.5 s) cannot slip through.

Usage:
  python3 -I workflow/scripts/qc_sheets.py VIDEO OUTDIR [--seams 9.0,18.0] [--windows 3-5,20-22] [--crop x,y,w,h]

Writes:
  OUTDIR/full_XX.png    the whole video at 6 fps, 3 s per sheet (18 frames each)
  OUTDIR/seam_T.png     every clip seam, T-1.5 s .. T+1.5 s at 10 fps (repeated / reversed actions)
  OUTDIR/win_A-B.png    every prop-interaction window from the beat sheet at 10 fps
--crop (fractions of the frame) zooms on the character so props are readable.
Look at EVERY sheet and fill in the prop ledger before showing anything to the user.
"""
import os, subprocess, sys

def sheet(video, start, dur, fps, out, crop, cols):
    n = max(1, int(round(dur * fps)))
    rows = (n + cols - 1) // cols
    vf = f"fps={fps}"
    if crop:
        x, y, w, h = crop
        vf += f",crop=iw*{w}:ih*{h}:iw*{x}:ih*{y}"
    vf += (",scale=220:-1,drawtext=text='%{pts\\:hms}':x=4:y=4:fontsize=13:fontcolor=yellow:"
           f"box=1:boxcolor=black@0.5,tile={cols}x{rows}")
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-ss", f"{max(start,0):.3f}", "-t", f"{dur:.3f}",
                    "-i", video, "-vf", vf, "-frames:v", "1", out], check=True)
    # drawtext shows time relative to the sheet start; the filename carries the absolute start
    print("wrote", out)

def main():
    a = sys.argv[1:]
    if len(a) < 2:
        print(__doc__); sys.exit(1)
    video, outdir = a[0], a[1]
    opts = dict(zip(a[2::2], a[3::2]))
    os.makedirs(outdir, exist_ok=True)
    dur = float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", video],
                               capture_output=True, text=True).stdout)
    crop = [float(v) for v in opts["--crop"].split(",")] if "--crop" in opts else None
    t, i = 0.0, 0
    while t < dur - 0.05:
        sheet(video, t, min(3.0, dur - t), 6, f"{outdir}/full_{i:02d}_from{t:.1f}s.png", crop, 6); t += 3.0; i += 1
    for s in filter(None, opts.get("--seams", "").split(",")):
        s = float(s); sheet(video, s - 1.5, 3.0, 10, f"{outdir}/seam_{s:.2f}s_from{s-1.5:.1f}s.png", crop, 10)
    for w in filter(None, opts.get("--windows", "").split(",")):
        x, y = map(float, w.split("-")); sheet(video, x, y - x, 10, f"{outdir}/win_{x:.1f}-{y:.1f}s.png", crop, 10)

if __name__ == "__main__":
    main()
