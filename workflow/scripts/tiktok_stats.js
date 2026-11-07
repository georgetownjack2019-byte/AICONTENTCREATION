// Usage: node tiktok_stats.js <tiktok video url> [more urls...]
// Prints one JSON line per video: views, likes, comments, shares, saves, age, duration, caption, sound.
// Reads the public video page with headless Chromium (no login). Read-only.
const { chromium } = require('playwright');
(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage({ userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36' });
  for (const url of process.argv.slice(2)) {
    const out = { url };
    try {
      await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 45000 });
      await page.waitForTimeout(2500);
      const raw = await page.evaluate(() => {
        const el = document.getElementById('__UNIVERSAL_DATA_FOR_REHYDRATION__');
        return el ? el.textContent : null;
      });
      const item = raw && JSON.parse(raw)?.__DEFAULT_SCOPE__?.['webapp.video-detail']?.itemInfo?.itemStruct;
      if (item) {
        const s = item.statsV2 || item.stats || {};
        const n = v => (v === undefined ? null : Number(v));
        const created = Number(item.createTime) * 1000;
        Object.assign(out, {
          author: item.author?.uniqueId,
          caption: (item.desc || '').slice(0, 200),
          sound: item.music?.title,
          sound_id: item.music?.id,
          sound_original: item.music?.original,
          hashtags: (item.textExtra || []).map(t => t.hashtagName).filter(Boolean),
          duration_s: item.video?.duration,
          posted: new Date(created).toISOString().slice(0, 10),
          age_days: Math.round((Date.now() - created) / 864e5 * 10) / 10,
          views: n(s.playCount), likes: n(s.diggCount), comments: n(s.commentCount),
          shares: n(s.shareCount), saves: n(s.collectCount),
        });
        if (out.views) out.share_rate_pct = Math.round(out.shares / out.views * 10000) / 100;
      } else {
        out.error = 'no embedded data (blocked, removed, or layout changed)';
      }
    } catch (e) { out.error = e.message.split('\n')[0]; }
    console.log(JSON.stringify(out));
  }
  await browser.close();
})();
