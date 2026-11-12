# Bowl prank ("money") video
Repost version from the other session (branch claude/practical-lamport-fbjl0x, daily/2026-11-08/repost/), copied here for timing analysis.

- `repost_dont-touch-the-bowl.mp4`: 36.0 s, hook "Never bet against a man with fast paws", dialogue audio.
- Timeline: setup 0–19 s · pause 19–20 s · reveal (bowl lifted, money gone) 20–22 s · pause 22–23 s · Yuki stunned, Kenji leaves 23–36 s.
- Sound plan: "Housewife" (Tate McRae) added in-app at 10–15% under the original sound, with the chorus aligned to the 20 s reveal.
- Suggested trim: end at ~30 s for faster loops (pending the user's choice).

## `bowl_SFX-ONLY.mp4` (music removed, voices + SFX kept, for in-app "Housewife")
Voices rebuilt from the original Seedance clips (A `46b832a1…` 0–12 s, B `05182e0f…` 12–24 s, C `c89b081a…` 0–8.41 s at 24 s, then 3.4 s still),
shifted +35 ms to match the original exactly (cross-correlation offset 0–2 ms, correlation 0.84–0.97). SFX from `bowl-v4-mix.json`. Built with `tools/sfx_only.py --voice`.
