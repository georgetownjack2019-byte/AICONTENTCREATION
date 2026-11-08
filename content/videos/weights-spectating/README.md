# Gym video: "when you grab weights too heavy and someone watches"
Made in the other session (branch claude/practical-lamport-fbjl0x, commit 3fb1319, v3 "natural pacing and a softer ending").
Copied here so the user can download it: `final_weights-spectating.mp4` (15.1 s, 720x1280) and `cover_weights-spectating.jpg`.

## v4 in progress: self-conscious Kenji (user: make it funnier by making Kenji more self-conscious)
Reaction stills (approved by Claude's check, awaiting user review):
1. Notices her watching (sweat drop, nervous side-glance): `1170429b-5466-4c2c-b559-2e60f2145cd3` · `stills/r1_notices.png`
2. Fake-casual on the bench (forced smile, forehead wipe): `a77cf99a-5646-4b1e-8167-656516c94725` · `stills/r2_fake_casual_v3.png`
3. Hides his face on the floor, Yuki sips: `7571b8f2-3081-433b-a6a5-1eb214e7aded` · `stills/r3_embarrassed_v3.png`
Earlier tries rejected: r2 v1 (not on the bench), r3 v1 (sitting up), v2s (copied blur band from the caption-blurred reference frames).
Reference frames from the video with the caption blurred: media `66777342-…` (bench), `a401b6e6-…` (floor).

## v4 result: `final_weights-spectating_v4.mp4` (15.1 s, 720×1280, −13.2 LUFS)
Clips (Wan 2.7, 3 s): notices `251b141f-7210-4ea9-ae64-c8d1e5e889ba` · fake-casual `ec6ab3b2-5bc9-48b6-97b6-8fae51904e08` · embarrassed `6379fdb7-de89-4371-ae18-5abd49cd4967`
Timeline: walk 0–3 · Yuki looks 3–4 · NEW notices + chest puff 4–6.25 (sting) · sits 6.25–7.75 · NEW forced smile 7.75–9.75 (slurp) · strain + fall 9.75–13.3 · NEW hides face 13.3–15.1 (sigh, slurp).
Same music (sneaky-prank) and SFX library as v3. Built with `build_v4.sh`. Credits for v4: stills 14 + clips ~13.5.

## v5: `final_weights-spectating_v5.mp4` (user: Kenji standing mid-floor was inconsistent; he should walk to the bench after grabbing the dumbbells)
Reordered, 0 credits: grab at rack 0–1.5 · Yuki looks 1.5–2.5 · he notices her while still at the rack 2.5–4.75 · walks to the bench 4.75–6.25 · rest unchanged. `build_v5.sh`.

## v6 in progress (user: Yuki must not be there at the start; he grabs the dumbbells, goes to the bench, THEN she comes over to watch)
New stills: 0 alone at rack `13b8a137-a1d5-4a99-b75c-0df1c047d696` · 1 alone on bench straining `3bb9bfb2-dec1-4652-af48-e54509a1838d` ·
2 she walks over, he freezes `6c100af1-f1ba-4710-8624-143f01835574` · 3 she stands, forced smile `6951aeab-80e8-4ff5-aa89-309c98012b6f`
Rejected: first bench set (Gym 3 ref 71a62307 is the rack area, so no bench under Kenji); shot 3 v2 (Yuki sitting).
Plan: rack(new) → walk (v3 1.8–3.4, no Yuki) → alone on bench (new) → she comes over (new) → forced smile (new) → v3 strain + fall → hides face (r3).
