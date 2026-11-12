#!/usr/bin/env python3
"""Rebuild a finished video's soundtrack with sound effects ONLY (no music), so music can be added in the
TikTok / Instagram app. Video is copied untouched.

Usage: python3 -I tools/sfx_only.py <in.mp4> <mix.json> <out.mp4> [--voice voice.wav] [--sfx-dir assets/sfx]
  mix.json: the other session's sound_mix format: {"sfx": [{"src": ".../name.mp3", "at": 1.2, "volume": 0.7}, ...]}
            ("music" and "original_volume" are ignored). SFX are looked up by file name in --sfx-dir.
  --voice:  optional dialogue/ambient track to keep under the SFX at full volume (e.g. rebuilt from the original clips).
Loudness is normalised to -14 LUFS like the original mixes.
"""
import argparse, json, os, subprocess

ap = argparse.ArgumentParser()
ap.add_argument('src'); ap.add_argument('mix'); ap.add_argument('out')
ap.add_argument('--voice'); ap.add_argument('--sfx-dir', default='assets/sfx')
a = ap.parse_args()

dur = float(subprocess.run(['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of', 'csv=p=0', a.src],
                           capture_output=True, text=True, check=True).stdout.strip())
sfx = json.load(open(a.mix)).get('sfx', [])
inputs, parts, labels = [], [], []
# silent base bed so the track always spans the whole video
parts.append(f"anullsrc=r=44100:cl=stereo,atrim=0:{dur}[base]"); labels.append('[base]')
idx = 0
if a.voice:
    inputs += ['-i', a.voice]
    parts.append(f"[{idx}:a]aformat=sample_rates=44100:channel_layouts=stereo,atrim=0:{dur}[vo]"); labels.append('[vo]'); idx += 1
for n, s in enumerate(sfx):
    path = os.path.join(a.sfx_dir, os.path.basename(s['src']))
    if not os.path.exists(path):
        raise SystemExit(f'missing SFX file: {path}')
    inputs += ['-i', path]
    ms = int(round(float(s['at']) * 1000))
    parts.append(f"[{idx}:a]aformat=sample_rates=44100:channel_layouts=stereo,adelay={ms}|{ms},volume={s.get('volume', 1.0)}[s{n}]")
    labels.append(f'[s{n}]'); idx += 1
parts.append(f"{''.join(labels)}amix=inputs={len(labels)}:normalize=0:duration=first,atrim=0:{dur},"
             f"loudnorm=I=-14:TP=-1.5:LRA=11[out]")
# input 0 is the video; shift audio input indices by 1
fc = ';'.join(parts)
for i in range(idx - 1, -1, -1):
    fc = fc.replace(f'[{i}:a]', f'[{i + 1}:a]')
cmd = ['ffmpeg', '-nostdin', '-v', 'error', '-y', '-i', a.src] + inputs + [
    '-filter_complex', fc, '-map', '0:v', '-map', '[out]', '-c:v', 'copy', '-c:a', 'aac', '-b:a', '192k',
    '-ar', '44100', '-shortest', '-movflags', '+faststart', a.out]
subprocess.run(cmd, check=True)
print('wrote', a.out)
