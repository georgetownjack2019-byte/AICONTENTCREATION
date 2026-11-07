# Daily Run: Kenji & Yuki viral-remake pipeline

This file is the instruction set a scheduled Claude session follows every day.
The human only does step 8 (review + post). Everything else is automated.

Repo layout used by the run:
- `characters/kenji-yuki.json`: locked character references (never change faces).
- `workflow/config.json`: budget, cadence, model settings.
- `daily/trends-log.md`: every trend already used (avoid repeats).
- `daily/YYYY-MM-DD/review.md`: today's review queue (output).
- `daily/performance.md`: human-filled results; read it to learn what works.

---

## 0. Setup checks (stop early if any fail)
1. `git pull` the working branch.
2. Read `workflow/config.json`, `characters/kenji-yuki.json`, the last 14 days of `daily/trends-log.md`, and `daily/performance.md`.
3. Higgsfield `balance`. If credits < `min_credit_reserve` + one clip, skip generation, write briefs only, and say "top up needed" at the top of the review file.

## 1. Trend search (free)
Follow `workflow/TREND_SEARCH.md`: collect candidates (inbox, Virlo, WebSearch, Creative Center) → verify each with
`node workflow/scripts/tiktok_stats.js <urls>` → apply `trend_filters` from config → score → write the top 3 to
`daily/YYYY-MM-DD/shortlist.md` (numbers + remake idea each).
If `approval_gate` is true: send the shortlist to the human (SendUserFile, proactive) and STOP. Generation resumes when
the human replies with picks. Otherwise continue with the top `videos_per_day`.

## 2. Remake brief (free)
For each pick, write in the review file:
- Trend name, stage, example link (credit the original format).
- **Beats with timing**, copying the original joke structure: hook (0–2 s) → setup → punchline → reaction/loop.
- **Cast**: Kenji solo / Yuki solo / duo. Rotate so the week has a mix. Use signature moves.
- **Scene outfits + location** (new each time; faces locked).
- **On-screen text hook** (≤ 8 words), caption (≤ 120 chars, ends with a question), 3–5 hashtags incl. `#KenjiAndYuki`, suggested sound.

## 3. Price + budget gate
- Build the `generate_video` params (step 4) and call once with `get_cost: true`.
- Total for the day must be ≤ `daily_credit_cap`. If not, drop the lowest-scored pick.

## 4. Generate
- Model and settings from `config.json` (default: `seedance_2_0`, mode `fast`, 720p, 8 s, 9:16, `genre: comedy`, `generate_audio: true`).
- `medias`: the reference sheet job IDs of characters in the scene, role `image_references`.
- Prompt template:
  > Vertical comedic short, stylized 3D animated feature-film style, filmed like a handheld phone video. @image1 is Kenji, a red-orange Shiba Inu who walks upright; @image2 is Yuki, a cream Shiba Inu who walks upright. Keep faces, eyes and fur markings exactly as in the references. Scene outfits: … Setting: … 0-2s: … 2-5s: … 5-6s: … 6-8s: … Sound: … No on-screen text, no subtitles.
- Submit all clips with `generate_video_batch`, then `jobs_wait` until terminal.
- Record every job ID in the review file immediately.

## 5. Automatic QC (free)
For each finished clip:
1. Download the mp4 into the scratchpad (`curl`).
2. `ffmpeg` extract one frame every 1 s into a contact sheet; Read the image.
3. Check: both characters look like their sheets (coat colour, ears, eyes), right number of characters, no extra limbs/merged bodies, punchline actually happens, vertical framing.
4. Verdict `PASS` / `FIX` / `FAIL`. One corrective regeneration max per clip, only if budget allows. Never loop.

## 6. Finish (free)
For PASS clips:
- Burn the on-screen hook: `workflow/scripts/finish_clip.sh <raw_url> daily/YYYY-MM-DD/final_<slug>.mp4 "<line 1>" "<line 2>"` (ASCII text only, no emoji; auto-sized; also writes a `_qc.png` sheet to inspect).
- Keep the raw Higgsfield link too, so the human can add text natively in TikTok instead.

## 7. Deliver for review
- Write `daily/YYYY-MM-DD/review.md` (template below), append picks to `daily/trends-log.md`, commit, push.
- `SendUserFile` the final mp4s + review.md with `status: proactive` so they reach the phone.

## 8. Human (≈ 15 min/day)
- Watch each clip → mark ✅ / ❌ / ✏️ (with a note) in `review.md` or reply in the session.
- Post approved clips: TikTok + Instagram Reels, turn **AI-generated label ON**, paste caption/hashtags, pick the trending sound in-app.
- 24 h later, add views/shares/follows to `daily/performance.md`. The next run reads it.

---

### review.md template
```
# Review queue: YYYY-MM-DD
Credits: start X → end Y (spent Z)

## 1. <Trend name> (<stage>)  QC: PASS
- Video: final_<slug>.mp4 · raw: <higgsfield url>
- Cast: duo · Hook text: "..."
- Caption: "..."  Hashtags: ...
- Sound: ...  Original format: <link>  Post at: <time>
- Your verdict: [ ] ✅ post  [ ] ❌ skip  [ ] ✏️ redo: ____
```

## Known generation pitfalls
- **Banknotes/currency trigger Higgsfield's IP filter** (status `ip_detected`, credits refunded). Replace money with a treat, a ticket or a gift card shape.
- `ip_detected` and other failures are refunded. Check `transactions` before retrying, and retry at most once with the trigger removed.
