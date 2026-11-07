#!/usr/bin/env python3
"""Parse a Virlo Content Research Agent markdown export and list recent high-view videos.

Usage: python3 -I parse_virlo_export.py <export.md> [--days 14] [--min-views 300000] [--out recent.json]

Virlo exports include videos published long before the agent ran, so always filter by publish date.
Joins each video with Virlo's AI 'Video Intelligence' summary (hook text, format, silent, summary).
"""
import argparse, json, datetime

def table(lines, title):
    i = lines.index(title); hdr = None; rows = []
    for l in lines[i + 1:]:
        if l.startswith('## '): break
        if not l.startswith('|') or set(l) <= set('|- '): continue
        c = [x.strip() for x in l.strip().strip('|').split(' | ')]
        if hdr is None: hdr = c; continue
        if len(c) == len(hdr): rows.append(dict(zip(hdr, c)))
    return rows

def num(x):
    try: return float(x)
    except (TypeError, ValueError): return 0.0

ap = argparse.ArgumentParser()
ap.add_argument('export'); ap.add_argument('--days', type=int, default=14)
ap.add_argument('--min-views', type=int, default=300000); ap.add_argument('--out')
a = ap.parse_args()
L = open(a.export, encoding='utf-8').read().split('\n')
vids = table(L, '## All Videos')
intel = {r['Video URL']: r for r in table(L, '## Video Intelligence')}
cutoff = (datetime.date.today() - datetime.timedelta(days=a.days)).isoformat()
out = []
for r in vids:
    v = num(r['Views'])
    if r['Published'] < cutoff or v < a.min_views or '/photo/' in r['Video URL']: continue
    sh = num(r['Shares']); d = intel.get(r['Video URL'], {})
    out.append({'url': r['Video URL'], 'platform': r['Platform'], 'published': r['Published'],
                'views': int(v), 'shares': int(sh), 'share_rate_pct': round(100 * sh / v, 2) if v else 0,
                'duration_s': r['Duration (s)'], 'views_per_follower': r['Views / Followers'],
                'description': r['Description'][:160], 'hook': d.get('Hook Text', '')[:160],
                'format': d.get('Content Format', ''), 'silent': d.get('Silent', ''), 'summary': d.get('Summary', '')[:400]})
out.sort(key=lambda x: -x['views'])
print(f"{len(vids)} videos in export, {len(out)} published since {cutoff} with >= {a.min_views:,} views")
for x in out[:40]:
    print(f"{x['published']} {x['platform'][:2]} {x['views']/1e6:5.2f}M share {x['share_rate_pct']:5}% {x['duration_s']:>4}s | {x['description'][:80]}")
if a.out: json.dump(out, open(a.out, 'w'), indent=1)
