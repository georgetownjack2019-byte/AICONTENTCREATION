# Kenji & Yuki: video-making guidelines

Owner: you. Edit this file anytime; every session reads it before planning a video.
**Every video must be FUNNY, DRAMATIC and ATTENTION-CATCHING**, in the **style of its base video**.

---

## 1. Attention-catching: win the first 2 seconds
- **Frame 1 is a face mid-emotion** (smirk, pout, side-eye, shock). Never an empty room or a slow establishing shot.
- **Text hook on screen from 0.0 s**: ≤ 8 words, a relatable "POV / when…" line that makes people want the ending.
- **Something moves or changes within 1 second** (a roll, a grab, a zoom, a sound hit).
- Bright, readable, vertical 9:16; characters fill at least a third of the frame.
- Keep it short: **8–16 s** for daily shorts. Every shot must earn its place; cut dead air.
- **End on a loop or a punchline face** (Kenji's deadpan to camera, Yuki's side-eye) so people rewatch.

## 2. Funny: the joke must land without explanation
- **Keep the original's joke and timing.** Copy the beats (setup → escalation → punchline → reaction), not the footage.
- **The setup makes the payoff hurt**: show what's at stake first (she's hugging his arm, so losing it matters).
- **Characters stay in the original's state** (asleep stays asleep; half-asleep actions are funnier).
- **Add one signature twist** at the end: Kenji's slow deadpan turn to camera, or Yuki's sassy side-eye.
- **Contrast is comedy**: calm → chaos, cute → savage, smug → defeated.
- Works **with the sound off** (expressions + text tell the joke) and **better with the sound on**.

## 3. Expressive but natural (updated 2026-11-12 from user feedback)
- **Match the base video's energy, not 200%.** The user rejected over-dramatic and "artificially happy" acting (gym v2, princess v1). Default: calm, natural, believable movement; one clear emotion per beat.
- Big expressions only where the base video has them (the reveal/punchline), and only as big as the base.
- **Camera punches in** on the reveal (fast zoom), slow push-ins on reactions.
- **Silence before the reveal**: cut the music for 1–2 s, then hit it.
- **Sound design is mandatory** on every video:
  - a music bed that fits the base video's mood (cozy lullaby, sneaky pizzicato, epic orchestral for fake drama, tense, chaotic…)
  - timed SFX on every beat: snores, huffs, **dramatic sting on the reveal**, whooshes, boings, hums, sighs
  - reusable library: `assets/` · mixer: `workflow/scripts/sound_mix.py` (normalises to -14 LUFS)

## 4. Match the base video's style
- **Adapt the look and tone to each original**: cute and cozy for a cute original, chaotic and loud for a prank,
  cringe/awkward for an office skit, cinematic for fake drama, deadpan for dry humour. Not every video has to be cute.
- Copy the original's **visual language**: camera style (static phone cam, handheld vlog, POV, close-up reactions),
  pacing, lighting mood, text style, and energy.
- Kenji and Yuki stay **recognisable** in every style: faces locked to the reference sheets (`characters/kenji-yuki.json`);
  expressions, outfits and rendering mood change with the video.
- **Normal, everyday styling**: casual, relatable outfits and settings that fit the scene (hoodies, pajamas, gym wear,
  work clothes; regular apartments, offices, kitchens, gyms).
- **Same script and storyboard, different look (user rule, 2026-11-07).** Copy the original's beats, timing, lines,
  camera angles and lighting mood, but never its specific visual details. Before making stills, list the original's
  outfits, props, set pieces and patterns and swap each one for a different everyday option in the same spirit:
  - outfits: never the original's colours/garments (e.g. grey tee + white cap + lilac tee -> navy hoodie + sage sweatshirt)
  - props and textiles: a patchwork quilt becomes a knit throw or a plain duvet; keep only props the joke needs (the bowl)
  - set pieces: a round porthole window becomes a regular window with curtains; change counter/cabinet colours
  - Check the contact sheet side by side with the original and redo any frame that looks like a copy.
- **Lock each video's outfits in every prompt (user rule, 2026-11-07).** The reference sheets show default outfits
  (Kenji: cream cable-knit sweater; Yuki: cream cardigan over a sage top), and generators drift back to them when a prompt
  only says "same outfits". So:
  - Write an **outfit line** in the storyboard for each video (e.g. "Kenji: plain navy pullover hoodie. Yuki: sage-green crewneck
    sweatshirt, tortoiseshell clip") and paste it word for word into **every** still and video prompt.
  - Pass the **approved scene frame first** in `medias`, then the reference sheets, and add "do not use the outfits from the
    reference sheets; faces and fur only".
  - Generate one variant at a time for scene stills (no `count: 2`), so a drifted variant is never offered.
  - Before showing or animating any frame, compare outfits, props and set with the approved key frame; redo any mismatch.

## 4b. Text style
- Captions use the **clean TikTok-native label**: black Inter SemiBold on a white rounded box
  (`python3 -I workflow/scripts/caption.py video|image ...`). No thick black outlines, no Arial-style bold.
- **Say it once**: one on-screen caption per video; the cover shows a clean frame + that same caption only
  (no second title). The post caption adds something new (a question, "send this to…"), never repeats the on-screen text.

## 4c. No AI glitches (user rule, 2026-11-07)
- **Design shots to avoid contact the AI gets wrong**: no hand-to-hand or arm-to-arm handling between the two characters
  (e.g. instead of "he lifts her paw off", write "he slides his face out from under her paw; it slips onto the pillow").
  Add "both characters keep their own arms; no limbs overlapping or passing through bodies" to every two-character prompt.
- **Glitch check before showing anything**: inspect every clip at **4–8 fps, zoomed on contact moments** (hugs, grabs, paws
  on faces, scoots), not just a 1–2 fps overview. Reject any frame with limbs passing through bodies, merged hands, extra or
  missing limbs, characters leaving the frame/bed unintentionally, or outfit/blanket changes. Regenerate or trim before delivery.

## 5. Never
- Real money or banknotes on screen (trips Higgsfield's copyright filter).
- Logos, brand names or real people's likeness. No copying another account's characters or look.
- Mean-spirited jokes (cheating, body-shaming, drugs). Keep it sponsor-safe.
- Dialogue-heavy formats that need lip-sync. Prefer silent jokes, text and SFX.

---

## Score before showing the user (each 1–5; post only if every score is ≥ 4)
| Check | Question |
|---|---|
| Hook | Would a stranger stop scrolling in the first 2 s? |
| Funny | Does the punchline land without explanation, at the original's timing? |
| Dramatic | Are expressions, motion and sound exaggerated enough? |
| Style match | Does it feel like the original (tone, camera, pacing, energy) while clearly being Kenji & Yuki? |
| Characters | Do Kenji and Yuki look like their reference sheets in every shot? |
| Sound | Are there music and SFX on every beat, at the right loudness? |

Write the scores in `daily/<date>/review.md` under each video. Below 4 anywhere means fix it before showing it to the user.

## 6. One-pass production (user rule, 2026-11-12): no wasted credits
Goal: every video is posted from the first animation. Every past remake came from a decision made too late, so all decisions are locked at the free stages.

**Gate 1 — Beat sheet (free).** Before any generation, show the user:
- the base video link + length, and a contact sheet of the original (1 frame per second);
- a beat-by-beat table: time · what happens in the original (every action and prop, e.g. "eats a snack", "pulls seat lever") · our version · energy level (calm / medium / big, matched to the original);
- target length (within ±10% of the original), outfits, props and set (all different from the original unless the user asks), on-screen text, music mood + SFX list;
- IP/risk check: no money, logos, brands, real people; avoid effects that glitch (wind in fur/hair, water, crowds of hands, flipping objects, big camera moves);
- the full credit estimate.
The user approves or edits; nothing is generated until then.

**Gate 2 — Stills (2 credits each).** One still per scene, outfit-locked, checked against the beat sheet before showing. The user approves every still. Changes here cost 2 credits, not 10+.

**Gate 3 — Animation.** Prompts copy the approved beat-sheet actions word for word, plus "natural, calm movement" unless the beat says otherwise. QC every clip (contact sheet) against the beat sheet before editing; a glitched clip is retried once silently, then reported.

**Gate 4 — Edit (free).** Timing, cuts, transitions, music and captions are all free to change; fix there instead of regenerating.

Lessons that caused past remakes: storyline differed from the original (bowl) · prop changed after animating (macaron → bill → check) · outfit drift from reference sheets · too fast / too dramatic acting (gym, princess) · missed small actions from the original (princess) · too short (sync) · effect glitches (wind wisps, neighbors).
