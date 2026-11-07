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

## 3. Dramatic: exaggerate everything
- **Expressions at 200%**: huge wobbly pouts, saucer eyes, fur puffing up, jaw drops.
- **Motion at 200%**: yanks, flips "like a pancake", skids, dramatic slow head turns.
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
