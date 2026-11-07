# Trend search: finding last week's most viral *human* videos

Goal: every morning, find human videos that went viral **in the last 7 days**, prove they are viral
with real numbers, and keep only the ones Kenji & Yuki can remake well. Credits are spent only on
those videos.

Tested 2026-11-07. ✅ = works from an automated session, ⚠️ = partial, ❌ = blocked.

## Step 1: Collect 20–30 candidate videos (free)
| Source | What it gives | Status |
|---|---|---|
| `daily/inbox.md`: links **you** paste while scrolling | Your For You page is the best signal for your niche | ✅ (human, 1 min/day) |
| [virlo.ai/trends](https://virlo.ai/trends) | ~12 trending formats/day with stage (Fresh/Rising/Peaking/Fading), # creators copying, week-over-week growth, example TikTok links | ✅ |
| WebSearch "went viral this week" + month/year | News-level viral human videos | ✅ (noisy) |
| TikTok Creative Center (logged out) | Top 3 US hashtags with 7-day views | ⚠️ (videos tab needs login) |
| tiktok.com/explore (headless browser) | Very viral videos, but often months old | ⚠️ (use only if < 7 days) |
| Reddit, YouTube trending | n/a | ❌ blocked / needs login |

## Step 2: Verify with real numbers (free)
`node workflow/scripts/tiktok_stats.js <url> ...` reads the public video page and returns
views, likes, comments, shares, saves, posting date, age, duration, caption and sound.

Example (2026-11-07):
```
door prank       posted 2026-10-31  2.9M views  42.2K shares  share rate 1.46%  32 s
"while they're out partying"  2026-10-31  8.2M views  46K shares  0.56%  7 s
toxic vs normal  2026-11-01  262K views  554 shares  0.21%  168 s
```
**Hard filters:**
- Posted ≤ 7 days ago.
- ≥ 1M views, **or** ≥ 300K views with share rate ≥ 1% (it's still climbing).
- The format is being copied (Virlo shows ≥ 20 creators), so it's a trend and not a one-off.
- Not dangerous to imitate, not sexual, not mocking a real private person, and the joke doesn't depend on the original person's face or voice.

## Step 3: Score the survivors (0–100)
| Factor | Weight | Why it matters for money |
|---|---|---|
| **Share rate** (shares ÷ views) | 30 | Shares drive reach and follows more than likes do |
| **Velocity** (views ÷ days since posting) | 20 | Shows the trend is still rising |
| **Remakeability** | 25 | Works with no or little dialogue, 1 location, ≤ 4 beats, fits an 8–15 s clip |
| **Theme fit** | 15 | Work / love / everyday life; couple formats get tagged most |
| **Freshness on our account** | 10 | Not used in the last 14 days (`daily/trends-log.md`) |

## Step 4: Beat sheet (free)
For the top picks, write down the original's beats with timestamps (hook → setup → punchline →
reaction) from the page (duration, caption, sound) plus a few screenshots of the playing video taken
by the headless browser. The screenshots are **private reference only**: never publish, reupload or
edit the original creator's footage. Then cast Kenji, Yuki or both, keep the timing, and add one
signature move at the end.

## Step 5: Shortlist → pick → generate
- The run writes the **top 3** to `daily/YYYY-MM-DD/shortlist.md` with numbers and a remake idea for each.
- **Auto mode (default):** the run generates the top 2.
- **Approval mode** (`config.json` → `"approval_gate": true`): the run stops after the shortlist and
  sends it to you. You reply with picks (e.g. "1 and 3") and only then are credits spent.
