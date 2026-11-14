# "What a healthy relationship looks like 😔" (Gate 1 beat sheet — waiting for approval)

Base: IG @misoandluna_official https://www.instagram.com/reel/DfftAE7x5x1 (21.1M views, 470K likes, 15.0 s, AI-animated bear couple).
Original: static side-view two-shot in a warm living room, both full body facing each other; on-screen text the whole time
"What a healthy relationship looks like 😔"; no words — angry cartoon gibberish ("b-b-b-b!") for 3 s, then music.
0-3 she yells and points, he yells back · 3-4 both turn away, arms crossed, pouting · 4-8 standoff, side-eye peeks · 8-11 her eyes fill with
tears, his anger melts · 11.5-12 they turn and step toward each other · 12-15 tight hug, eyes closed, camera pushes in.

## Ours (15 s, same script/timing, tension + held dramatic reactions)
| # | Time | Original | Kenji & Yuki | Tension | Reaction (held ≥ 1 s) |
|---|---|---|---|---|---|
| 1 | 0-3 | She yells + points, he yells back | Yuki yells and jabs a paw at Kenji, Kenji yells back, both angry (cartoon gibberish, no real words) | PEAK | furious frowns, ears pinned back, cheeks flushed |
| 2 | 3-4 | Both turn away, arms crossed | Both spin away with a "hmph!", arms crossed, noses up | high | pouting, chin up |
| 3 | 4-8 | Standoff, side-eye peeks | Standoff, back to back. Kenji sneaks a side-eye peek, snaps away when she moves; then Yuki peeks, snaps away | rising | slow side-eyes, held |
| 4 | 8-11 | Her eyes fill with tears, he softens | Yuki's lip trembles, big glossy tears; Kenji's frown melts into guilty puppy eyes | rising → release | held teary eyes / guilty look |
| 5 | 11-12 | They turn to each other | They turn and step toward each other | release | — |
| 6 | 12-15 | Tight hug, camera push-in | Tight hug, eyes closed, Yuki's happy-teary smile, Kenji rests his chin on her head (zoom-in in edit) | warm payoff | content, eyes closed |

Look (different from the bears): Kenji: navy t-shirt, grey sweatpants. Yuki: oversized lavender hoodie, white scrunchie on one ear
(original: no clothes, pink headband bow). Set: our own cozy living room, side view, warm lamp bokeh, a plant and a bookshelf (original: dark-green couch).
On-screen text (whole video, clean label): "what a healthy relationship looks like 😔".
Sound: two-voice cartoon gibberish argument 0-3 s (SFX), "hmph" at 3 s, soft tension → emotional piano from 8 s swelling into the hug, a sniffle at 9 s.

## Guideline checks
- Prop ledger: no props (only Yuki's scrunchie, must stay on her ear in every shot).
- Glitch prevention: 4 short clips (≤ 2 actions each), chained only from still frames; each next prompt starts from the finished state.
  Risky moves kept simple: arms crossing (stated as "already crossed" from shot 3 on), hug = arms around each other, no hand details.
- Dense QC (qc_sheets.py) at every seam and at the turn + hug before showing.

## Production
1 still (2 cr) → 4 Wan clips × 5 s (30 cr) → SFX + music (~3 cr). Total ≈ 35 credits.

## Gate 2 stills (key frames; each is the end of one clip and the start of the next)
K1 argue e78d0ac0-ec5f-4efd-82b4-be0e391ab08f · K2 standoff bd64d499-79fd-4a4b-b798-b1b436158e02 · K3 tears bcefc4ed-4c35-4d70-a1c5-1e66edf7e55d · K4 hug f3d02e68-e2bb-4848-a96e-a2708414ace9
Rejected: d6ee9da3 / 4e4b1d1b / d3b80d0c (Yuki pale "cream" + invented ponytail; two were double-charged by widget timeouts).
Change from Gate 1: no scrunchie (it made the model invent a ponytail); Yuki wears light grey leggings.
Clips: C1 K1→K2 (yell, spin away, cross arms) 5 s · C2 K2→K3 (side-eye peeks, then tears/guilt) 5 s · C3 K3→K4 (turn, step in, hug) 5 s = 15 s, Wan 2.7 start+end frames ≈ 22.5 credits.
Clips: C1 21465a97-0e0b-4555-8e5b-989a5a3f9288 · C2 8785d1d5-c1f9-4350-8084-4ebe74f6acbb · C3 863645a1-341a-442d-8f19-7a41a250ed35 · audio: gibberish 0914399c, hmph 2f8f1a51, sniffle 0455c830, piano bd51a670
QC: C1 21465a97 PASS. C2 8785d1d5 FAIL (Kenji 180° head twist 1.5-2.7 s; ears pointed→floppy morph). C3 863645a1 FAIL (floppy ears snap upright mid-hug). Cause: K3 still had floppy ears → new K3 f2f78a6a-c3fa-4632-8bef-2c1f361b86ee (upright ears). Redo: C2 6a3fe7b1-8362-4a45-b2ee-6f3feffdcaf1, C3 033236d3-1531-453c-967c-585835072b47.
Final: final_healthy-relationship.mp4 (15.1 s) = C1 21465a97 + C2 6a3fe7b1 + C3 033236d3 (zoom-in from 2 s). Sound: gibberish 0.0, hmph 3.05, sniffle 8.6, piano 7.6→end, hum 13.4. -15.7 LUFS. Dense QC at seams 5.0 / 10.0: clean.
Credits: stills ~16 (incl. 4 wasted on timeouts/off-model), clips 5 × 7.5 = 37.5, audio ~2 → ~56.
v2 pacing (user: too quick, not cute): free re-edit to 22.2 s — turn-away slowed ×0.6, standoff ×0.75, 1.6 s push-in hold on Yuki's tears, hug ×0.8 + 1.8 s held ending; new 14 s piano (83cef52d) from 9.6 s. -13.4 LUFS.
Cute style test still: 54538354-5540-4223-ae58-f3b1afbeb712 (chibi: big round heads, big sparkly eyes, blush, chubby bodies) → daily/2026-11-12/cute-style-test.jpg, waiting for user.
v2 sound: cute squeaky bicker (6c43b69b, pitched +4 st) + cute hmph (fa3138c9); argument visuals still too aggressive (user) — options: redo clip 1 pouty (~9.5 cr) or full cute-style redo (~31 cr).
New pouty K1: 6019c46e-4466-4199-9fdb-51001f88bca6 (waiting for user OK, then clip 1 K1→K2 ~7.5 cr)
Heated-cute K1: 92defc1e-331e-4906-804f-8227bbabf798 · sound options: A 5f64f497 (b-b-b/bla-bla babble), B 2916e994 (chipmunk babababa/nyeh nyeh). Waiting for user pick.
Heated-cute clip 1 (K1h→K2): c99748eb-9531-4479-9e28-4b5169c3409e · Shiba SFX: yips 9de5eec8, huff 9c0efb1c, whimper 9845f42a, happy sigh 0345917d
v3 final (22.2 s): heated-cute clip 1 c99748eb (QC pass) + C2 6a3fe7b1 + C3 033236d3; Shiba SFX (yips 0.0, huff 3.05, whimpers 11.1/12.9, happy sigh 18.9); piano from 9.25. -13.9 LUFS. New cover from the heated-cute argue frame.
v3 sound fix (user: sound weird): mirelo SFX were mostly hiss; boosted hiss = static. Now denoised+gated yips (2 voices), whimper, sigh; huff dropped; continuous 19 s piano (8ae69819) from 3.6 s; yips softened (lowpass 7 kHz).
v4 sound: Seedance 2.5 video_edit synced argument audio (29806f63, 21 cr) replaces argue SFX 0-5.7 s; piano rebuilt continuous 4.2 s→end (no loop gap); -14 LUFS.
