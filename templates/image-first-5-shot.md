# Template: image-first 5-shot remake (~28 credits, ~15 s)

Used for: "POV: his arm is officially mine" (2026-11-07). Reuse for any short reaction or couple-moment format.

1. **Plan** (free / 10 vidIQ credits): `vidiq_watch_shortform_content` on the original → shot list with timestamps.
2. **Stills** (2 credits each, Nano Banana Pro, 9:16):
   - Shot 1 first, with both reference sheets as `image_references`. It locks the set, lighting and outfits.
   - Shots 2–5 in one `generate_image_batch`, each with the relevant sheet(s) **plus shot 1's job ID** as references.
3. **Animate** only shots that need motion (Wan 2.7, 720p, 4 s, 6 credits each, `start_image` = the approved still).
   Quick facial-reaction shots stay as stills with a slow zoom (free).
4. **Assemble**: `python3 -I workflow/scripts/assemble.py edit.json out.mp4` (see `daily/2026-11-07/arm-steal-edit.json`).
5. **Caption**: `HOOK_SECONDS=999 workflow/scripts/finish_clip.sh out.mp4 final.mp4 "POV: ..."`.

Cost comparison: one 15 s Seedance 2.0 Fast clip = 37.5 credits with no per-shot control;
this template = ~28 credits, with each shot approved before animating.
