// Usage: node find_copies.js <sound_id|#hashtag> [max_age_days=7]
// Lists recent videos that use the same sound (or hashtag) with their stats, to check whether a
// format still works for other creators. Read-only, no login. Captures TikTok's own page API responses.
const { chromium } = require('playwright');
(async () => {
  const key = process.argv[2]; const maxAge = Number(process.argv[3] || 7);
  const url = key.startsWith('#') ? `https://www.tiktok.com/tag/${encodeURIComponent(key.slice(1))}`
                                  : `https://www.tiktok.com/music/x-${key}`;
  const browser = await chromium.launch();
  const page = await browser.newPage({ userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36' });
  const seen = new Map();
  const add = i => { if (i && i.id && !seen.has(i.id)) seen.set(i.id, i); };
  page.on('response', async r => {
    if (!/item_list/.test(r.url())) return;
    try { const j = await r.json(); (j.itemList || []).forEach(add); } catch (e) {}
  });
  try {
    await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 45000 });
    await page.waitForTimeout(4000);
    const raw = await page.evaluate(() => document.getElementById('__UNIVERSAL_DATA_FOR_REHYDRATION__')?.textContent);
    if (raw) { const s = JSON.parse(raw).__DEFAULT_SCOPE__ || {}; for (const v of Object.values(s)) (v?.itemList || []).forEach(add); }
    for (let k = 0; k < 6; k++) { await page.mouse.wheel(0, 4000); await page.waitForTimeout(2000); }
  } catch (e) { console.log(JSON.stringify({ key, error: e.message.split('\n')[0] })); }
  const now = Date.now();
  const rows = [...seen.values()].map(i => {
    const s = i.statsV2 || i.stats || {}; const age = (now - i.createTime * 1000) / 864e5;
    return { author: i.author?.uniqueId, id: i.id, age_days: Math.round(age * 10) / 10,
             views: Number(s.playCount), shares: Number(s.shareCount), desc: (i.desc || '').slice(0, 70) };
  });
  const recent = rows.filter(r => r.age_days <= maxAge);
  const views = recent.map(r => r.views).sort((a, b) => a - b);
  const med = views.length ? views[Math.floor(views.length / 2)] : 0;
  const last3 = recent.filter(r => r.age_days <= 3);
  const summary = { key, url, found: rows.length, recent: recent.length,
    median_views_recent: med,
    pct_recent_over_100k: recent.length ? Math.round(100 * recent.filter(r => r.views >= 1e5).length / recent.length) : null,
    last3d_count: last3.length,
    last3d_median_views: last3.length ? last3.map(r => r.views).sort((a, b) => a - b)[Math.floor(last3.length / 2)] : null };
  console.log(JSON.stringify(summary));
  recent.sort((a, b) => b.views - a.views).slice(0, 8).forEach(r => console.log('  ' + JSON.stringify(r)));
  await browser.close();
})();
