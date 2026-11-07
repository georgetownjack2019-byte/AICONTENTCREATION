# Remake rules (user priority)

**Goal:** the remake should feel like the original video, shot for shot, with Kenji & Yuki,
and be even more dramatic and attention-grabbing.

## 1. Match the original as closely as possible
Before planning, break the original down shot by shot:
- Get the exact script: on-screen text and spoken lines, word for word (vidIQ transcript /
  Higgsfield video analysis / the user's Virlo notes).
- Shot list with **timestamps**: number of shots, length of each, where the cuts are.
- Camera framing per shot (POV, close-up, wide, handheld, static) and camera moves.
- Who does what, the exact gestures and reaction beats, and the punchline timing (the pause before it).
- The sound: same trending sound or original audio, and where the beat or drop lands.

Then remake it **1:1**: same number of shots, same order, same framing, same timing, same
text (only names or pronouns adapted), same punchline beat.

> **Core guideline: keep the original's script and storyboard, but our characters, outfits
> and props must look clearly different.**

What stays the same: script, on-screen text, shot order, timing, framing, camera moves,
gestures, reaction beats, punchline.

What must look **clearly different** from the original:
- **Characters:** always Kenji & Yuki from the official reference sheets, never styled to
  resemble the original creators.
- **Outfits:** a different garment type, colour *and* style from what the original people
  wear (e.g. original wears a black hoodie → Kenji wears a cream knit polo). Pick from the
  everyday outfit table in `characters/PROMPTS.md`.
- **Props:** same *function*, different look (e.g. original's white coffee mug → a glass
  of iced matcha; their phone case → a plain one; their car → a different model and colour).
  Never copy branded or distinctive props.
- **Setting:** same *type* of place (kitchen, office, car), but a different layout, décor
  and colour scheme. Our look: soft, muted, cozy 3D cartoon.

In the review table (step 2), every shot lists the original outfit/prop next to ours, so
the difference is easy to check.

### Length rule (user priority)
**The remake's total length must match the original's (within ±0.2 s), and every shot keeps the
original's start and end times.** Don't trim for pace. If an AI clip has a bad stretch, fix it
(redo the clip or choose a different usable segment of the same length), never shorten the video.
Only change the length when the user asks for it (e.g. the longer Yuki routine in the skincare remake).
Always measure the original (`ffprobe`) and write its timeline into the plan before generating.

## 2. Make it more viral than the original
- **Frame 1 = a face mid-reaction** plus the hook text. No slow start.
- **Exaggerate the cartoon acting:** bigger eyes, longer deadpan stare, sharper side-eye,
  dramatic freezes. That's the advantage of cartoon characters.
- **Punch-in zoom** on the punchline reaction, plus a sound effect (record scratch, "bruh",
  dramatic sting) if the trend allows.
- **Same length as the original** (see the length rule above); make it feel tighter with sharper acting and sound, not by cutting.
- **Loop the ending** back into frame 1 when the format allows it.
- **Captions** big, centred and high-contrast, synced to the beat.
- Before posting: run Higgsfield's virality predictor on the final edit and fix any weak
  hook or slow section it flags.

## 3. Hard limits
- Recreate the *format, script and storyboard*, never reuse the original creator's footage,
  face or branding.
- Use the original sound from the platform's sound library (in-app), not a ripped audio file.
- Always turn on the AI label.

## Plan format Claude sends for review (step 2)
| # | Time | Original shot | Remake shot (Kenji/Yuki) | Text / line | Framing | Original outfit/props → ours |
|---|---|---|---|---|---|---|
| 1 | 0.0–1.5 s | … | … | … | … | black hoodie, white mug → cream polo, iced matcha |
Plus: the viral boosters added, total credit cost.
