// Usage: node virlo_trends.js > trends.json
// Scrapes https://virlo.ai/trends: each trend's title, card text (stage, creators, w/w change) and the
// example videos from different creators (used as the "copies" for the copy check). Read-only.
const { chromium } = require('playwright');
(async () => {
  const b = await chromium.launch(); const p = await b.newPage();
  await p.goto('https://virlo.ai/trends', { waitUntil: 'networkidle', timeout: 60000 }); await p.waitForTimeout(3000);
  const trends = await p.evaluate(() => {
    const out = {};
    document.querySelectorAll('a[href*="tiktok.com/@"], a[href*="youtube.com/shorts"], a[href*="instagram.com/reel"]').forEach(a => {
      let el = a, h = null;
      for (let k = 0; k < 12 && el; k++) { el = el.parentElement; h = el && el.querySelector('h2,h3,h4'); if (h) break; }
      if (!h) return;
      const title = h.innerText.trim();
      if (!out[title]) out[title] = { title, card_text: el.innerText.replace(/\s+/g, ' ').slice(0, 400), examples: [] };
      if (!out[title].examples.includes(a.href)) out[title].examples.push(a.href);
    });
    return Object.values(out).filter(t => t.examples.length >= 2 && !/what's trending/i.test(t.title));
  });
  console.log(JSON.stringify({ fetched: new Date().toISOString(), trends }, null, 1));
  await b.close();
})();
