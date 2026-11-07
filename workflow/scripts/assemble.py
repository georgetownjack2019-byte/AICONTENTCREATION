#!/usr/bin/env python3
"""Assemble a vertical video from an ordered list of shots (video clips and stills).

Usage: python3 -I assemble.py <edit.json> <out.mp4>

edit.json: {"shots": [
  {"type": "video", "src": "<url or path>", "trim": 4.0},          # optional trim (seconds)
  {"type": "still", "src": "<url or path>", "duration": 2.0, "zoom": 1.12}  # slow push-in
]}
Every shot is normalised to 720x1280, 30 fps, stereo 44.1 kHz (stills get silence), then concatenated.
"""
import json, os, subprocess, sys, tempfile, urllib.request

W, H, FPS = 720, 1280, 30

def fetch(src, d, i):
    if not src.startswith('http'): return src
    ext = os.path.splitext(src.split('?')[0])[1] or '.bin'
    p = os.path.join(d, f'src{i}{ext}'); urllib.request.urlretrieve(src, p); return p

def run(cmd): subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)

def has_audio(p):
    r = subprocess.run(['ffprobe', '-v', 'error', '-select_streams', 'a', '-show_entries', 'stream=index', '-of', 'csv=p=0', p], capture_output=True, text=True)
    return bool(r.stdout.strip())

edit, out = json.load(open(sys.argv[1])), sys.argv[2]
with tempfile.TemporaryDirectory() as d:
    parts = []
    for i, s in enumerate(edit['shots']):
        src = fetch(s['src'], d, i); part = os.path.join(d, f'part{i}.mp4')
        if s['type'] == 'still':
            dur, z = float(s.get('duration', 2)), float(s.get('zoom', 1.1)); n = int(dur * FPS)
            vf = (f"scale={W*2}:{H*2}:force_original_aspect_ratio=increase,crop={W*2}:{H*2},"
                  f"zoompan=z='1+({z}-1)*on/{n}':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d={n}:s={W}x{H}:fps={FPS}")
            run(['ffmpeg', '-y', '-loop', '1', '-i', src, '-f', 'lavfi', '-i', 'anullsrc=r=44100:cl=stereo',
                 '-vf', vf, '-t', str(dur), '-c:v', 'libx264', '-pix_fmt', 'yuv420p', '-c:a', 'aac', '-shortest', part])
        else:
            vf = f"scale={W}:{H}:force_original_aspect_ratio=increase,crop={W}:{H},fps={FPS}"
            cmd = ['ffmpeg', '-y', '-i', src]
            if not has_audio(src): cmd += ['-f', 'lavfi', '-i', 'anullsrc=r=44100:cl=stereo', '-shortest']
            if s.get('trim'): cmd += ['-t', str(s['trim'])]
            run(cmd + ['-vf', vf, '-c:v', 'libx264', '-pix_fmt', 'yuv420p', '-c:a', 'aac', '-ar', '44100', '-ac', '2', part])
        parts.append(part)
    lst = os.path.join(d, 'list.txt'); open(lst, 'w').write(''.join(f"file '{p}'\n" for p in parts))
    run(['ffmpeg', '-y', '-f', 'concat', '-safe', '0', '-i', lst, '-c:v', 'libx264', '-crf', '20', '-c:a', 'aac', '-movflags', '+faststart', out])
print('wrote', out)
