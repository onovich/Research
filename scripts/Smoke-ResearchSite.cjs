'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');

const repoRoot = path.resolve(__dirname, '..');
const manifest = JSON.parse(fs.readFileSync(path.join(repoRoot, 'public-site.json'), 'utf8'));
const publicRoot = path.resolve(repoRoot, manifest.source || '.');
const outputRoot = process.env.RESEARCH_SMOKE_DIR || fs.mkdtempSync(path.join(os.tmpdir(), 'research-site-smoke-'));

function resolveChrome() {
  const candidates = [
    process.env.RESEARCH_CHROME,
    process.env.CHROME_PATH,
    process.platform === 'win32' && process.env.ProgramFiles ? path.join(process.env.ProgramFiles, 'Google', 'Chrome', 'Application', 'chrome.exe') : null,
    process.platform === 'win32' && process.env['ProgramFiles(x86)'] ? path.join(process.env['ProgramFiles(x86)'], 'Google', 'Chrome', 'Application', 'chrome.exe') : null,
    process.platform === 'win32' && process.env.LOCALAPPDATA ? path.join(process.env.LOCALAPPDATA, 'Google', 'Chrome', 'Application', 'chrome.exe') : null,
    chromium.executablePath()
  ].filter(Boolean);
  return candidates.find(candidate => fs.existsSync(candidate));
}

function fileUrl(relativePath) {
  return pathToFileURL(path.join(publicRoot, relativePath)).href;
}

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

async function run() {
  fs.mkdirSync(outputRoot, { recursive: true });
  const executablePath = resolveChrome();
  assert(executablePath, 'Chrome or a Playwright Chromium executable is required. Set RESEARCH_CHROME when necessary.');
  const browser = await chromium.launch({ headless: true, executablePath });

  async function open({ locale, width, height = 900, relativePath, javaScriptEnabled = true }) {
    const context = await browser.newContext({
      viewport: { width, height },
      locale,
      colorScheme: 'light',
      javaScriptEnabled
    });
    const page = await context.newPage();
    const errors = [];
    page.on('pageerror', error => errors.push(`pageerror: ${error.message}`));
    page.on('console', message => {
      if (message.type() === 'error') errors.push(`console: ${message.text()}`);
    });
    await page.goto(fileUrl(relativePath), { waitUntil: 'load' });
    await page.waitForTimeout(120);
    return { context, page, errors };
  }

  try {
    const routingCases = [
      { locale: 'en-US', expected: 'index.html', label: 'English locale' },
      { locale: 'zh-CN', expected: 'index.html', label: 'Chinese locale without auto-redirect' },
      { locale: 'fr-FR', expected: 'index.html', label: 'unsupported-locale fallback' }
    ];
    for (const test of routingCases) {
      const session = await open({ locale: test.locale, width: 768, relativePath: 'index.html' });
      assert(decodeURIComponent(session.page.url()).endsWith(test.expected), `${test.label}: expected ${test.expected}, got ${session.page.url()}`);
      assert(session.errors.length === 0, `${test.label}: ${session.errors.join(' | ')}`);
      console.log(`route: ${test.label} -> ${test.expected}`);
      await session.context.close();
    }

    const visualCases = [
      { locale: 'en-US', width: 320, relativePath: 'index.html', screenshot: 'home-en-320.png' },
      { locale: 'zh-CN', width: 320, relativePath: 'index.zh-CN.html', screenshot: 'home-zh-320.png' },
      { locale: 'en-US', width: 768, relativePath: 'about.html', screenshot: 'about-en-768.png' },
      { locale: 'zh-CN', width: 768, relativePath: 'about.zh-CN.html', screenshot: 'about-zh-768.png' },
      { locale: 'en-US', width: 320, relativePath: 'tools/research-to-html/index.html', screenshot: 'skill-en-320.png' },
      { locale: 'zh-CN', width: 320, relativePath: 'tools/research-to-html/index.zh-CN.html', screenshot: 'skill-zh-320.png' },
      { locale: 'en-US', width: 1440, height: 1000, relativePath: 'tools/research-to-html/index.html', screenshot: 'skill-en-1440.png' },
      { locale: 'en-US', width: 375, relativePath: 'crowdfunding-and-indie-games-research/index.html', screenshot: 'report-en-375.png' },
      { locale: 'zh-CN', width: 375, relativePath: 'crowdfunding-and-indie-games-research/index.zh-CN.html', screenshot: 'report-zh-375.png' },
      { locale: 'en-US', width: 1440, height: 1000, relativePath: 'crowdfunding-and-indie-games-research/index.html', screenshot: 'report-en-1440.png' },
      { locale: 'en-US', width: 375, relativePath: 'indie-game-crowdfunding-genres-and-gameplay/index.html', screenshot: 'game-fit-en-375.png' },
      { locale: 'zh-CN', width: 375, relativePath: 'indie-game-crowdfunding-genres-and-gameplay/index.zh-CN.html', screenshot: 'game-fit-zh-375.png' },
      { locale: 'en-US', width: 1440, height: 1000, relativePath: 'indie-game-crowdfunding-genres-and-gameplay/index.html', screenshot: 'game-fit-en-1440.png' }
    ];
    for (const test of visualCases) {
      const session = await open(test);
      const metrics = await session.page.evaluate(() => ({
        language: document.documentElement.lang,
        innerWidth,
        scrollWidth: document.documentElement.scrollWidth,
        h1Count: document.querySelectorAll('h1').length,
        languageOptions: document.querySelectorAll('[data-language-option]').length
      }));
      assert(metrics.innerWidth === test.width, `${test.screenshot}: viewport is ${metrics.innerWidth}, expected ${test.width}`);
      assert(metrics.scrollWidth <= metrics.innerWidth, `${test.screenshot}: horizontal overflow ${metrics.scrollWidth}/${metrics.innerWidth}`);
      assert(metrics.h1Count === 1 && metrics.languageOptions === 2, `${test.screenshot}: structural controls are incomplete`);
      assert(session.errors.length === 0, `${test.screenshot}: ${session.errors.join(' | ')}`);
      await session.page.screenshot({ path: path.join(outputRoot, test.screenshot) });
      console.log(`visual: ${test.screenshot} (${metrics.language}, ${metrics.innerWidth}px)`);
      await session.context.close();
    }

    const seoCases = [
      { relativePath: 'index.html', canonical: 'https://research.onovich.com/' },
      { relativePath: 'index.zh-CN.html', canonical: 'https://research.onovich.com/index.zh-CN.html' },
      { relativePath: 'about.html', canonical: 'https://research.onovich.com/about.html' },
      { relativePath: 'about.zh-CN.html', canonical: 'https://research.onovich.com/about.zh-CN.html' },
      { relativePath: 'crowdfunding-and-indie-games-research/index.html', canonical: 'https://research.onovich.com/crowdfunding-and-indie-games-research/' },
      { relativePath: 'crowdfunding-and-indie-games-research/index.zh-CN.html', canonical: 'https://research.onovich.com/crowdfunding-and-indie-games-research/index.zh-CN.html' },
      { relativePath: 'indie-game-crowdfunding-genres-and-gameplay/index.html', canonical: 'https://research.onovich.com/indie-game-crowdfunding-genres-and-gameplay/' },
      { relativePath: 'indie-game-crowdfunding-genres-and-gameplay/index.zh-CN.html', canonical: 'https://research.onovich.com/indie-game-crowdfunding-genres-and-gameplay/index.zh-CN.html' },
      { relativePath: 'tools/research-to-html/index.html', canonical: 'https://research.onovich.com/tools/research-to-html/' },
      { relativePath: 'tools/research-to-html/index.zh-CN.html', canonical: 'https://research.onovich.com/tools/research-to-html/index.zh-CN.html' }
    ];
    for (const test of seoCases) {
      const session = await open({ locale: 'en-US', width: 1024, relativePath: test.relativePath });
      const seo = await session.page.evaluate(() => {
        const jsonLd = Array.from(document.querySelectorAll('script[type="application/ld+json"]')).map(script => JSON.parse(script.textContent));
        return {
          canonical: document.querySelector('link[rel="canonical"]')?.href,
          alternates: Array.from(document.querySelectorAll('link[rel="alternate"][hreflang]')).map(link => [link.hreflang, link.href]),
          description: document.querySelector('meta[name="description"]')?.content,
          robots: document.querySelector('meta[name="robots"]')?.content,
          openGraph: Boolean(document.querySelector('meta[property="og:title"]') && document.querySelector('meta[property="og:image"]')),
          twitter: document.querySelector('meta[name="twitter:card"]')?.content,
          jsonLdCount: jsonLd.length
        };
      });
      assert(seo.canonical === test.canonical, `${test.relativePath}: canonical mismatch ${seo.canonical}`);
      assert(seo.alternates.length === 3 && seo.alternates.every(([, href]) => href.startsWith('https://')), `${test.relativePath}: hreflang links are incomplete or relative`);
      assert(seo.description && seo.robots.includes('index') && seo.openGraph && seo.twitter === 'summary_large_image' && seo.jsonLdCount > 0, `${test.relativePath}: SEO metadata is incomplete`);
      assert(session.errors.length === 0, `${test.relativePath}: ${session.errors.join(' | ')}`);
      console.log(`seo: ${test.relativePath}`);
      await session.context.close();
    }

    async function testPillarReportTools(locale, relativePath, expected) {
      const session = await open({ locale, width: 375, relativePath });
      await session.page.click('[data-reading-mode="full"]');
      await session.page.click('#theme-button');
      const state = await session.page.evaluate(() => ({
        reading: document.documentElement.dataset.reading,
        theme: document.documentElement.dataset.theme,
        themeLabel: document.querySelector('#theme-button').getAttribute('aria-label'),
        cost: document.querySelector('#cost-total').textContent,
        filterCount: document.querySelectorAll('[data-game-filter]').length,
        hasScorecard: Boolean(document.querySelector('#decision-tool')),
        hasCompanionLink: Boolean(document.querySelector('a[href*="indie-game-crowdfunding-genres-and-gameplay"]'))
      }));
      assert(state.reading === 'full', `${locale}: pillar reading control failed`);
      assert(state.theme === 'dim' && expected.theme.test(state.themeLabel), `${locale}: pillar theme control is not localized: ${JSON.stringify(state)}`);
      assert(state.cost === '96%', `${locale}: pillar cost calculator failed: ${JSON.stringify(state)}`);
      assert(state.filterCount === 0 && state.hasScorecard === false, `${locale}: pillar must not duplicate the companion filter or scorecard: ${JSON.stringify(state)}`);
      assert(state.hasCompanionLink, `${locale}: pillar is missing the companion-report link`);
      assert(session.errors.length === 0, `${locale}: ${session.errors.join(' | ')}`);
      console.log(`pillar tools: ${locale} ${JSON.stringify(state)}`);
      await session.context.close();
    }

    await testPillarReportTools('en-US', 'crowdfunding-and-indie-games-research/index.html', { theme: /light mode/ });
    await testPillarReportTools('zh-CN', 'crowdfunding-and-indie-games-research/index.zh-CN.html', { theme: /日间模式/ });

    async function testFocusedReportTools(locale, relativePath, expected) {
      const session = await open({ locale, width: 375, relativePath });
      await session.page.click('[data-reading-mode="full"]');
      await session.page.click('#theme-button');
      await session.page.click('[data-game-filter="action"]');
      for (const select of await session.page.locator('[data-score]').all()) {
        const values = await select.locator('option').evaluateAll(options => options.map(option => option.value).filter(Boolean));
        await select.selectOption(values[values.length - 1]);
      }
      const state = await session.page.evaluate(() => ({
        reading: document.documentElement.dataset.reading,
        theme: document.documentElement.dataset.theme,
        themeLabel: document.querySelector('#theme-button').getAttribute('aria-label'),
        filter: document.querySelector('#game-filter-status').textContent,
        score: document.querySelector('#decision-score').textContent,
        heading: document.querySelector('#decision-heading').textContent
      }));
      assert(state.reading === 'full', `${locale}: focused-report reading control failed`);
      assert(state.theme === 'dim' && expected.theme.test(state.themeLabel), `${locale}: focused-report theme control failed: ${JSON.stringify(state)}`);
      assert(expected.filter.test(state.filter), `${locale}: focused-report filter output is not localized: ${state.filter}`);
      assert(state.score === '10/10' && expected.heading.test(state.heading), `${locale}: focused-report scorecard failed: ${JSON.stringify(state)}`);
      assert(session.errors.length === 0, `${locale}: ${session.errors.join(' | ')}`);
      console.log(`focused tools: ${locale} ${JSON.stringify(state)}`);
      await session.context.close();
    }

    await testFocusedReportTools('en-US', 'indie-game-crowdfunding-genres-and-gameplay/index.html', { filter: /^Showing /, heading: /Ready/, theme: /light mode/ });
    await testFocusedReportTools('zh-CN', 'indie-game-crowdfunding-genres-and-gameplay/index.zh-CN.html', { filter: /筛选后显示/, heading: /可以进入/, theme: /日间模式/ });

    const persisted = await open({ locale: 'en-US', width: 768, relativePath: 'index.html' });
    await persisted.page.click('[data-language-option="zh-CN"]');
    await persisted.page.waitForLoadState('load');
    assert(decodeURIComponent(persisted.page.url()).endsWith('index.zh-CN.html'), 'Language switch did not open the Chinese counterpart.');
    await persisted.page.goto(fileUrl('crowdfunding-and-indie-games-research/index.html'), { waitUntil: 'load' });
    await persisted.page.waitForTimeout(120);
    assert(decodeURIComponent(persisted.page.url()).endsWith('crowdfunding-and-indie-games-research/index.html'), 'Stored preference must not auto-redirect an indexable report URL.');
    assert(persisted.errors.length === 0, `Locale persistence: ${persisted.errors.join(' | ')}`);
    console.log('manual locale switching without automatic redirects: passed');
    await persisted.context.close();

    const noScript = await open({ locale: 'en-US', width: 320, relativePath: 'crowdfunding-and-indie-games-research/index.html', javaScriptEnabled: false });
    const noScriptState = await noScript.page.evaluate(() => ({
      detailDisplay: getComputedStyle(document.querySelector('.detail-layer')).display,
      innerWidth,
      scrollWidth: document.documentElement.scrollWidth
    }));
    assert(noScriptState.detailDisplay !== 'none', 'No-script mode hides full evidence.');
    assert(noScriptState.scrollWidth <= noScriptState.innerWidth, 'No-script mode has page-level horizontal overflow.');
    console.log(`no-script: ${JSON.stringify(noScriptState)}`);
    await noScript.context.close();

    console.log(`Research browser smoke passed. Screenshots: ${outputRoot}`);
  } finally {
    await browser.close();
  }
}

run().catch(error => {
  console.error(error.stack || error);
  process.exit(1);
});
