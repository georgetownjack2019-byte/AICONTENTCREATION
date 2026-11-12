# Trending sounds: matches for our videos

Source: TikTok Commercial Music Library trending chart via Higgsfield (`tiktok_music_trending`, connector f71b289a-…), US, 7-day, pulled 2026-11-12.
CML = licensed tracks safe for any account type (incl. Business / brand deals). Matches are by title/genre/rank (Claude can't listen): preview before using.

| Video | Track | Use |
|---|---|---|
| Gym (spectating) | Invictus, Trailerhead (Epic #1) + cinematic stinger (#15) | Mock-heroic on the grab, silence when Yuki arrives, stinger on the fall |
| Gym, alternative | Self Aware, Mark Allan Wolfe (#2) | Low under SFX; the title matches self-conscious Kenji |
| Everything in sync | Take Me (To The Moon), Ian Asher & D A N N Y (#3) | Synced moves on the beat |
| Bowl prank | Final Game Showdown, ProdByLucK (#7) | Showdown tension |
| Work: not fake enough | A ballad that suits an elegant tea party, Mio (#72) | Ironic polite music under the fake cheer |
| Escaped / arm thief | Stay Close to Me, Muspace (Chill #2) | Cozy bedtime, clingy Yuki |
| Skincare | Cheerful and comical piano, Noru (#33) | Light comedy under the routine |
| Passenger princess | Ok I Like It, Milky Chance (#8) | Car-ride vibe |

Trends noticed: vacuum-cleaner sounds (#6, #13, #17, #44): idea "Kenji inhales Yuki's snacks like a vacuum" · Christmas tracks rising: plan a holiday video.
How to post: TikTok → Add sound → search title → original sound ~100%, track 10–20% (louder if it's the main track). Instagram → Audio search; else use a ↗ trending track in the same style.
Refresh weekly (US or FR).

---

## Instagram Reels audio (pulled 2026-11-12)
Sources: weekly third-party trackers (SocialBee, CreatorDB, SoundMatcha, Later, SocialPilot; no official Instagram chart) + vidIQ outlier search of top couple-comedy and AI-animal Reels (Oct 29 – Nov 12).

Trending this week: All I Want For Christmas Is You (Mariah Carey, #1 on several trackers) · Housewife (Tate McRae, duo choreography trend) ·
Angel of My Dreams (JADE, beauty creators) · November Rain (Guns N' Roses) · Blue Moon (Zara Larsson) · Nicole Kidman (ADÉLA) · APT. (ROSÉ & Bruno Mars).
What top AI-animal / couple Reels use: upbeat playful instrumental + SFX (pop, thud, jump-scare hook) or a recognisable classic
(I Want You Back, I Just Called To Say I Love You cover, It's the Most Wonderful Time of the Year, Milkshake remix).

| Video | Instagram sound | Why |
|---|---|---|
| Escaped / arm thief | All I Want For Christmas Is You | Ironic (she won't let him go); #1 this week |
| Everything in sync | Housewife (Tate McRae) | Duo trend + synced duo joke |
| Work: not fake enough | It's the Most Wonderful Time of the Year | Sarcastic cheer vs deadpan Kenji |
| Skincare | Angel of My Dreams (JADE) | Glam/beauty sound of the moment |
| Gym | November Rain (guitar solo on the fall) | Mock-epic drama |
| Bowl prank | I Want You Back (Jackson 5) | Fun, proven on a 3D couple skit |
| Passenger princess | APT. | Car singalong |
Use: original sound 100%, song 10–25% (louder for music-driven edits). Creator accounts have the full library; Business accounts are limited.

---

## Effects-only versions: ON HOLD (user cancelled on 2026-11-12; video content will be edited first)
The song suggestions above stay valid. These files are drafts only; rebuild them with `tools/sfx_only.py` after the content edits.

### Draft list (music removed so the song is added in the app)
| # | Video | File | In-app song (TikTok / Instagram) |
|---|---|---|---|
| 1 | Everything in sync | `content/videos/in-sync-remake/in-sync_FINAL_v4_SFX-ONLY.mp4` | Ok I Like It / APT. |
| 2 | Bowl / money prank | `content/videos/bowl/bowl_SFX-ONLY.mp4` (voices kept) | Housewife / Housewife |
| 3 | He thought he escaped | `content/videos/escaped/escaped_SFX-ONLY.mp4` | Stay Close to Me / All I Want For Christmas Is You |
| 4 | Gym v6 | `content/videos/weights-spectating/final_weights-spectating_v6_SFX-ONLY.mp4` | Invictus / November Rain |
| 6 | Passenger princess | `content/videos/passenger-princess/passenger-princess_SFX-ONLY.mp4` | Ok I Like It / APT. |
Unchanged (keep their own music): 5 work, 7 skincare, 8 door prank.
Tool: `tools/sfx_only.py` (rebuilds a soundtrack from a mix JSON with SFX only, optional `--voice` track).
