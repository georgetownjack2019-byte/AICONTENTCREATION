# Tool test: vidIQ + Virlo (2026-11-07)

## Verdict
| | Virlo (free page) | vidIQ (connector, free plan) |
|---|---|---|
| Platforms | TikTok (+ a few YouTube) | **TikTok + Instagram Reels** |
| What it finds | Named trend *formats*, stage (Fresh→Fading), # creators copying, 3 examples | Individual **outlier** videos (views ÷ creator's median), last 7 days, by topic |
| Extras | Trend growth % | AI breakdown of the **0–3 s hook**, format template, pacing, audio, audience |
| Shares | via our `tiktok_stats.js` | not provided → use `tiktok_stats.js` |
| Accuracy check | n/a | ✅ TikTok views matched page stats (5.9M vs 6.2M live; 980K vs 1.0M) |
| Cost | Free | 5 credits/search; free plan = 150 credits/month (~30 searches). Used 20 today, 110 left. |
| Automatable | ✅ (`virlo_trends.js`) | ✅ (connector tools in Claude) |

**Best combo:** vidIQ to discover (TikTok + Instagram, topic-targeted, outlier score) → `tiktok_stats.js` for shares →
Virlo to confirm the format is a multi-creator trend and its stage.

Caveat: vidIQ's AI descriptions are occasionally off (e.g. a caption about a footballer on a gym video), so watch
the original or use `vidiq_watch_shortform_content` (10 credits) before writing the brief.

## Cross-platform confirmation of Virlo's #1 trend
"While they're out partying btw" also outperforms on **Instagram**: @lvte.cruz 2.3M (249× median), plus variant
"Your competition is at a Halloween party rn btw" 796K (392×). Now confirmed on TikTok (3 creators, 2.1–8.2M) and Instagram.

## New candidates found by vidIQ (last 7 days, 500K+ views)
| Idea | Platform | Views (× creator median) | Length | Kenji & Yuki fit |
|---|---|---|---|---|
| "POV: you don't fit in at work because you're not fake enough": deadpan vs bubbly coworkers | IG | 4.5M (34×) | short | ⭐ Kenji deadpan in the breakroom, everyone else over-cheerful |
| "When HR hires your new crush": flustered video call | IG | 9.0M (482×) | short | ⭐ Yuki flustered on a call with new hire Kenji (love + work) |
| "She said 'just a movie'": quiet couch moment → absurd physical gag | IG | 5.4M (69×) | 13 s | ⭐ duo, no dialogue, physical comedy |
| "We are not the same": Pilates in a face mask, 1 shot | TikTok | 1.0M (121×), 1.35% share rate | 6 s | ⭐ Yuki, cheapest possible clip |
| "Your boss fires the employee keeping the company running": **animated** skit | TikTok | 6.2M (174×) + 1.2M (164×), 2 creators | 140 s | Pattern confirmed and already animated → future 60 s+ episode; dialogue-heavy |
| "How to look productive at work": listicle | IG | 5.1M (4×, big account) | short | Kenji, good series idea |
| Vacuum gag / "flirting like he does" couple skits | IG | 2.6–2.7M | short | duo physical comedy |

**Pattern worth noting:** two different *animated* stick-figure work skits are 160–175× outliers. Audiences are
rewarding animated characters in workplace stories right now, which is good news for Kenji & Yuki.
