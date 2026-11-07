# Money-first strategy: costs, revenue projection, video length

Nothing here is guaranteed. Platform payout rates come from third-party creator reports (sources at
the bottom), and the plan prices come from blog snapshots. Check both in-app (TikTok Studio → Creator
Rewards; higgsfield.ai/pricing) before committing money.

---

## 1. Cost of posting 2 videos a day (60/month)

**Measured Higgsfield prices** (live `get_cost` quotes, 2026-11-07):
| Model | Price |
|---|---|
| Seedance 2.0 Fast, 720p | **2.5 credits/second** (8 s = 20, 15 s = 37.5) |
| Seedance 2.0 Fast, 480p | 1 credit/second |
| Seedance 2.5, 720p (premium) | 7 credits/second |

Assume **30% of clips need a redo** (×1.3).

| Option (2/day) | Credits/video | Credits/month | ≈ $/month at Ultra rate |
|---|---|---|---|
| A. 8 s shorts, 720p Fast | 26 | **1,560** | $67 |
| B. 15 s shorts, 720p Fast | 49 | 2,925 | $126 |
| C. 65 s long videos, 720p Fast | 211 | 12,675 | $545 |
| D. 65 s long videos, 480p Fast | 84 | 5,070 | $218 |
| F. 65 s long videos, Seedance 2.5 | 592 | 35,490 | $1,526 |
| **E. Recommended mix** (2 shorts/day + 4 stitched 60 s+ episodes + 2 premium follow-ups) | — | **~2,180** | **$94** |

**Which plan.** Third-party prices, so verify before buying:
- Plus is $59/mo with 1,200 credits. That is **not enough** for 2/day.
- **Ultra is $129/mo, or $99/mo billed annually, with 3,000 credits.** It covers option A, B or E with spare credits for retakes.
- Your current Plus plan covers about 1 short a day.

**Realistic monthly budget for 2/day: ~$129** (Ultra monthly). Claude, CapCut and in-app music add $0.

## 2. Revenue projection (Instagram + TikTok)

How each platform pays:
- **TikTok Creator Rewards.** You need 10K followers, 100K views in the last 30 days, age 18+, and an eligible country. It pays **only for original videos over 1 minute**, about **$0.40–$1.00 per 1,000 qualified views** in the US. Short videos earn $0 directly.
- **Instagram.** There is no standard pay-per-view, and bonuses are invite-only and mostly scaled back. Plan for **$0 from views**. Instagram makes money through **brand deals**, affiliate links and subscriptions.
- **Brand deals** (both platforms): roughly **$5–$12 per 1,000 views** of the sponsored video. This is where accounts like this make most of their money.

**Monthly revenue around month 6**, three scenarios (illustrative, not a promise):
| | Slow (most common) | Solid | Breakout |
|---|---|---|---|
| Followers (TikTok / IG) | < 10K / < 5K | 30K / 15K | 250K / 100K |
| TikTok qualified 60 s+ views/month | 0 (not eligible) | 1.5M | 10M |
| Creator Rewards | $0 | $600–$1,500 | $4,000–$10,000 |
| Brand deals | $0 | 1–2 small deals: $200–$960 | 4 deals: $4,000–$9,600 |
| Affiliate / TikTok Shop | $0 | $50–$300 | $500–$3,000 |
| **Total/month** | **$0** | **~$850–$2,800** | **~$8,500–$22,600** |
| Higgsfield cost | −$129 | −$129 | −$129 to −$260 |

What moves you from "slow" to "solid" is not posting more. It is **hit rate**: picking proven viral
formats (see `workflow/TREND_SEARCH.md`), recognisable characters, and turning every hit into a
series. Expect the first 30–60 days to earn nothing while you test.

## 3. Do you need videos longer than 1 minute? Yes, but not yet, and not generated from scratch

You're right that **TikTok only pays Creator Rewards on videos over 1 minute**. But:
1. **No payout before eligibility.** Until 10K followers + 100K views/30 days, longer videos earn $0. Short remakes are what get you there fastest: they are cheaper, finish more often, and the algorithm pushes them more.
2. **Generating a full 65 s video costs ~8× a short** (211 vs 26 credits). At ~$0.70 per 1,000 views, a $9 long video needs ~13K qualified views just to break even. Most videos from a new account won't get that.
3. **Stitch your own shorts into 60–75 s "episodes".** Combine 5–7 related shorts from the week ("Kenji & Yuki: the whole week of chaos"). Add a 10–15 s new intro or ending (~40 credits). Burn chapter text. Total cost **~40 credits** instead of ~211. It's all your own original footage, so it qualifies as original content.
4. **Phase it:**
   - **Days 1–45:** 2 shorts/day (8–15 s). Optimise for follows and shares.
   - **Once eligible:** keep 2 shorts/day **plus 1 stitched 60–75 s episode every 1–2 days**. Post the episode on TikTok only. Instagram gets the shorts.
   - **Proven series:** generate original 60 s+ episodes (premium budget) only for formats that already got > 500K views.

## 4. Money rules for every run
- Spend credits only on trends that passed the verify step (≥ 1M views in ≤ 7 days, or ≥ 300K with ≥ 1% share rate).
- 1 retake max per clip. Never top up automatically.
- Follow-up rule: any video over 3× your median views gets a Part 2 within 48 h (premium model allowed).
- Weekly review (Sunday): double down on the format with the highest **follows per 1K views**. Drop formats under 50% average watch time 3 times in a row.

### Sources
- TikTok Creator Rewards requirements and RPM: [ttcalculator.net](https://ttcalculator.net/guides/creator-rewards-program/), [argil.ai](https://www.argil.ai/blog/how-much-does-tiktok-pay-per-view), [elev8or.io](https://www.elev8or.io/blog/tiktok-creator-rewards-program-explained)
- Instagram Reels monetization: [lilachbullock.com](https://www.lilachbullock.com/instagram-money-per-1000-views/), [clickanalytic.com](https://www.clickanalytic.com/blog/how-much-does-instagram-pay-for-1000-views/), [vidpros.com](https://vidpros.com/how-much-does-instagram-pay-per-million-views/)
- Higgsfield plans: [krea.ai](https://www.krea.ai/blog/higgsfield-pricing-explained-2026-unlimited-credits-and-real-monthly-costs), [heygen.com](https://www.heygen.com/blog/higgsfield-pricing)
