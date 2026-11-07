# Remake: "Yuki's skincare vs Kenji's skincare"

**Original:** https://www.instagram.com/reel/DSR7wUijkCg/ (found via Virlo). 11 s, 2D pastel penguins,
no dialogue, playful music + SFX. Analyzed with vidIQ watch.

| # | Time | Original | Remake | Text | Still (job) |
|---|---|---|---|---|---|
| 1 | 0:00–0:03 | Pink penguin: lotion pump, cream brush, sheet mask, happy | Yuki: serum dropper + gua sha, row of bottles, robe + spa headband | `Yuki's skincare :` | `stills/1_yuki_skincare.png` (`6abd0341-705a-45d3-bb23-5c9d908b81f8`) |
| 2 | 0:03–0:07 | Blue penguin ignores products, tap on, splashes water | Kenji in a grey tee splashes water, soap only, tap running | `Kenji's skincare :` | `stills/2_kenji_splash_final.png` (media `6a1d3f8d-d5df-4b86-9c0e-1345bb5fc7ae`; AI fix + local hue correction) |
| 3 | 0:07–0:09 | He opens his eyes, glowing and sparkling | Kenji beaming, fluffy fur, sparkles | `Kenji's skincare :` | `stills/3_kenji_glow.png` (`69c4ea25-4be9-494b-81e1-ea37ae94064e`) |
| 4 | 0:09–0:11 | Both side by side; she's full glam, awkward glance, sweat drop | Both at the double vanity; Yuki full glam (lashes, blush) side-eyes, sweat drop; Kenji taller, cheerful, sparkling | `Kenji's skincare :` | `stills/4_punchline_v3.png` (`7d16fc61-4b28-429d-bd7c-5f1ec4be3cbf`) |

**SFX:** playful track · squish/pop on her products · water splash · "ding" sparkle · "pop" on the sweat drop.
**Different from the original:** characters, 3D style, outfits, props, bathroom; no white card frame or logo.
**Boosters:** zoom on the shot 3 sparkle; freeze-frame on Yuki's side-eye; ≤11 s.
Status: user asked to fix shots 2 and 4 (Kenji coat colour) → fixed → animating with Kling 3.0 std, 5 s, no sound.
Clip jobs: 1 `1e445bf5-c4f1-4fff-a615-14809c1ece24` · 2 `2e4ccf3a-f8ed-4d9d-9fbb-15172315f227` · 3 `33b70b63-a047-470c-b000-f808464bebf1` · 4 `838eb411-53d3-4a6d-ab5a-3ff1b8f627b0`

Lesson: AI image edits over- or under-shoot small colour changes; a local hue correction (ffmpeg `hue`) is exact and free.

## Result
- Clip 4 first try rejected (Kenji's bounce warped his face and shrank him) → redone with minimal motion: `d47fa1fe-29b5-4956-bd8b-aa703684391b`.
- Clips: `clips/1_yuki_skincare.mp4`, `2_kenji_splash.mp4`, `3_kenji_glow.mp4`, `4_punchline.mp4` (716×1284, 5 s each).
- **Rough cut:** `rough_cut_v1.mp4`, 11.5 s, 1080×1920, silent, text burned in. Built with `tools/rough_cut.sh shots.txt`.
  Cuts: clip1 0–3 s · clip2 0–4 s · clip3 2.5–4.5 s · clip4 1.0–3.5 s.
- To finish in CapCut: playful music + SFX (squish on her products, splash, "ding" on his sparkle, "pop" on the sweat drop).
- Credits for this video: stills 6 + fixes 6 + clips 37.5 ≈ 49.5.

## Final edit (done by Claude, no CapCut)
`final.mp4`: 11.5 s, 1080×1920, AAC audio, −14.6 LUFS. Rebuild with `./build_final.sh`.
- Music: ElevenLabs Music v2.5, 12 s instrumental (`audio/music.mp3`, job `41d3653f-8da1-4547-9c9c-1de1b765ec5f`)
- SFX: splash (`6e1377dd…`), sparkle (`3ba3b1ad…`), sweat drop (`f7cc9bc5…`); the squish came back silent twice, so a synthesised "bloop" pop is used instead
- Zoom 1.0 → 1.55 on Yuki's side-eye at 9.6 s
- Audio credits: ~4.25
