# Remake: "i need to go to therapy" / "the therapy:" (Yuki solo)
Original: https://www.instagram.com/reel/Dd-ju9atQGq/ (user request 2026-11-14). 7.10 s, 720×1280, 5 shots, music only.
Cuts at 1.63 · 3.03 · 4.33 · 5.57 s. Text: "i need to go to therapy" (0–1.63) → "the therapy:" (1.63–end).

| # | Time | Original | Yuki | Original → ours |
|---|---|---|---|---|
| 1 | 0–1.63 | Sad on cream sofa, hugging knees (wide) | Sad on sofa, droopy ears, wobbly eyes, tiny rain cloud | cream sweater/black leggings → sage knit cardigan, white tee, light grey leggings; white sofa → taupe linen sofa |
| 2 | 1.63–3.03 | Nail salon, tech paints nails, eyes closed smile | Nail bar, eyes closed, blissful | white marble → light oak, sage; nude → soft pink polish |
| 3 | 3.03–4.33 | Walks out of café with giant iced coffee, sipping | Struts out sipping giant iced matcha | coffee → matcha |
| 4 | 4.33–5.57 | Sunny street, arms full of shopping bags | Same, happy bounce | black/cream bags → sage/blush/kraft bags |
| 5 | 5.57–7.10 | Spa facial, fluffy blanket, cucumber eyes, candle | Spa chair, blanket, relaxed smile | cucumbers → gold under-eye patches; candle → diffuser |
Boosters: 200% sad face in shot 1; ding/sparkle + quick zoom on each cut; hold the blissful end face for the loop.
Production: 5 stills (10 cr) · Wan on shots 3–4 · stills + push-in on 1, 2, 5 · SFX only (song added in-app) · ≈ 18–20 cr.
Status: plan sent to the user for approval.

## Stills (user said go, 2026-11-16), 10 credits
1 sad `8ab97228-8f53-4956-a79b-1c29714f09f0` (ears drooped as a sad expression; flag for review) · 2 nails `1b545441-56d5-4745-8045-513c779d4b7e` ·
3 matcha `99e5d196-d84b-49dd-bc25-50cdfc4d3ea7` · 4 shopping `b21c210d-7b85-4e7b-b68f-a817ec39ef92` · 5 spa `1b0a821d-a1be-4717-99e7-07b33bc2b6f8`
Status: awaiting user review → animate 3 + 4 (Wan), push-ins on 1, 2, 5, edit at 7.10 s.

## Final (user: no music, song added in-app)
`therapy_FINAL_SFX-ONLY.mp4`: 7.10 s (original 7.10 s), 1080×1920, −14.1 LUFS. Clips (Wan 2.7, 2 s): matcha `2102b73a-a177-463c-9f45-b00122388b40` · shopping `3473fe21-9113-427c-aec7-3f4a33b85ed8`.
Shots 1, 2, 5 = stills with a push-in. Captions "i need to go to therapy" (0–1.63) / "the therapy:" (1.63–end), tools/caption.py label.
SFX: sad "wah" on the rain cloud, sparkle on each therapy shot, slurp, bag rustle, happy hum. No music. `build_final.sh`.
Cover: `cover_therapy.jpg` (sad shot + hook) + `cover_ig_grid_3x4.jpg`, `cover_ig_1x1.jpg`. Credits: stills 10 + clips ~6 = ~16.

### Captions
TikTok: `my therapist accepts matcha and gel nails 💅🍵 #shiba #shibainu #aianimation #selfcare #retailtherapy`
Pinned: `what's YOUR kind of therapy? 👇`
Instagram: `Therapy? Booked. 💅 Matcha, nails, shopping and a spa day 🍵🛍️` / `Tag the friend who needs this therapy session 👇` + #shibainu #shiba #aianimation #3danimation #selfcare #retailtherapy #selfcaresunday #relatable
Pinned: `be honest… which one is your therapy: nails, matcha, shopping or spa? 👀`

## v2 audio (user: sad sound for the first ~2 s; they add happy music in-app for the therapy part)
Sad violin + piano (ElevenLabs Music `7c5efe42-7653-4705-ad9c-b3dba0adf727`, `audio/sad_intro.mp3`, segment 1.70–3.33 s) under 0–1.63 s only,
fade-out ending exactly at the cut; "wah" lowered under it. Therapy part (1.63–7.10) = SFX only. Intro ≈ −17 dB mean, rest ≈ −23 dB.
Tip for the user: in TikTok, start the happy song at ~1.6 s (or keep it low in the first 1.6 s) so it doesn't cover the sad intro.
