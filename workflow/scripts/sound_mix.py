#!/usr/bin/env python3
"""Add a music bed and timed sound effects to a video (output normalised to -14 LUFS, TikTok/Reels loudness).

Usage: python3 -I sound_mix.py <mix.json> <in.mp4> <out.mp4>

mix.json: {
  "original_volume": 0.3,                     # keep the clips' own ambience quietly (0 = mute)
  "music": {"src": "music.wav", "volume": 0.35,
            "segments": [[0, 4.0], [7.5, 15.6]],   # music plays only in these windows (silence = comedic pause)
            "fade": 0.25},
  "sfx": [{"src": "sting.mp3", "at": 6.0, "volume": 1.0}, ...]
}
"""
import json, subprocess, sys

cfg, src, out = json.load(open(sys.argv[1])), sys.argv[2], sys.argv[3]
dur = float(subprocess.run(['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of', 'csv=p=0', src],
                           capture_output=True, text=True).stdout)
inputs, chains, mixes = ['-i', src], [], []
chains.append(f"[0:a]volume={cfg.get('original_volume', 0.3)},apad,atrim=0:{dur}[orig]"); mixes.append('[orig]')
n = 1
m = cfg.get('music')
if m:
    inputs += ['-stream_loop', '-1', '-i', m['src']]; f = m.get('fade', 0.25)
    segs = [(a, min(b, dur)) for a, b in m.get('segments', [[0, dur]])]
    chains.append(f"[{n}:a]asplit={len(segs)}" + ''.join(f"[mus{k}]" for k in range(len(segs))))
    for k, (a, b) in enumerate(segs):
        chains.append(f"[mus{k}]atrim={a}:{b},asetpts=PTS-STARTPTS,afade=t=in:d={f},"
                      f"afade=t=out:st={max(b - a - f, 0)}:d={f},volume={m.get('volume', 0.35)},"
                      f"adelay={int(a * 1000)}|{int(a * 1000)}[m{k}]")
        mixes.append(f"[m{k}]")
    n += 1
for k, s in enumerate(cfg.get('sfx', [])):
    inputs += ['-i', s['src']]; ms = int(float(s['at']) * 1000)
    chains.append(f"[{n}:a]volume={s.get('volume', 1.0)},adelay={ms}|{ms}[s{k}]"); mixes.append(f'[s{k}]'); n += 1
chains.append(''.join(mixes) + f"amix=inputs={len(mixes)}:normalize=0:duration=first,alimiter=limit=0.95,loudnorm=I=-14:TP=-1.5:LRA=11[aout]")
cmd = ['ffmpeg', '-y', *inputs, '-filter_complex', ';'.join(chains), '-map', '0:v', '-map', '[aout]',
       '-c:v', 'copy', '-c:a', 'aac', '-b:a', '192k', '-t', str(dur), out]
subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
print('wrote', out)
