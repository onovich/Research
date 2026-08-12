'use strict';

const fs = require('fs');
const path = require('path');
const { chromium } = require('playwright');

const repoRoot = path.resolve(__dirname, '..');
const outputRoot = path.join(repoRoot, 'site', 'assets', 'og');

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

const cards = [
  {
    file: 'research-library-en.png',
    lang: 'en',
    mark: 'R',
    eyebrow: 'INDEPENDENT RESEARCH LIBRARY',
    title: 'Start with a question.\nLeave with a clearer decision.',
    note: 'Evidence · Limits · Practical next steps'
  },
  {
    file: 'research-library-zh-CN.png',
    lang: 'zh-CN',
    mark: '研',
    eyebrow: '独立专题研究',
    title: '从一个具体问题出发，\n带走更清楚的判断。',
    note: '证据 · 限制 · 可行动的下一步'
  },
  {
    file: 'crowdfunding-indie-games-en.png',
    lang: 'en',
    mark: 'CF',
    eyebrow: 'CROWDFUNDING FIELD STUDY · 2026',
    title: 'Crowdfunding products\nand indie games',
    note: 'Net profit · Platform fit · Channel value'
  },
  {
    file: 'crowdfunding-indie-games-zh-CN.png',
    lang: 'zh-CN',
    mark: '筹',
    eyebrow: '众筹专项调查 · 2026',
    title: '众筹商品与独立游戏',
    note: '净利润 · 平台适配 · 渠道价值'
  },
  {
    file: 'indie-game-crowdfunding-fit-en.png',
    lang: 'en',
    mark: 'IG',
    index: 'RESEARCH / 02',
    eyebrow: 'INDIE GAME CROWDFUNDING · 2026',
    title: 'Indie game\ncrowdfunding fit',
    note: 'Audience · Playable proof · Bounded scope'
  },
  {
    file: 'indie-game-crowdfunding-fit-zh-CN.png',
    lang: 'zh-CN',
    mark: '游',
    index: '专题 / 02',
    eyebrow: '独立游戏众筹适配 · 2026',
    title: '独立游戏\n众筹适配',
    note: '受众 · 可玩证明 · 有边界的范围'
  },
  {
    file: 'research-to-html-en.png',
    lang: 'en',
    mark: 'R→H',
    index: 'WORKFLOW / 01',
    eyebrow: 'EVIDENCE-BACKED AI WORKFLOW',
    title: 'Research to HTML',
    note: 'Industry research · Bilingual web reports'
  },
  {
    file: 'research-to-html-zh-CN.png',
    lang: 'zh-CN',
    mark: '研→页',
    index: '工作流 / 01',
    eyebrow: '有证据的 AI 调研工作流',
    title: '把行业调研变成双语网页报告',
    note: '可复核证据 · 低阅读压力 · 隐私安全发布'
  },
  {
    file: 'starter-story-vibe-coding-en.png',
    lang: 'en',
    mark: 'VC',
    index: 'RESEARCH / 03',
    eyebrow: 'ONLINE BUSINESS PATTERNS · 2026',
    title: 'Online projects\nthat make money',
    note: 'Profit evidence · Pure online · AI-assisted build'
  },
  {
    file: 'starter-story-vibe-coding-zh-CN.png',
    lang: 'zh-CN',
    mark: '赚',
    index: '专题 / 03',
    eyebrow: '线上商业模式 · 2026',
    title: '赚钱的\n线上项目',
    note: '利润证据 · 纯线上 · AI 辅助开发'
  }
];

function escapeHtml(value) {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function template(card) {
  const title = escapeHtml(card.title).replace(/\n/g, '<br>');
  return `<!doctype html>
<html lang="${card.lang}">
<head><meta charset="utf-8"><style>
*{box-sizing:border-box}html,body{width:1200px;height:630px;margin:0;overflow:hidden}
body{position:relative;color:#18302d;background:#eaf0ef;font-family:"MiSans","PingFang SC","Microsoft YaHei",Arial,sans-serif}
.frame{position:absolute;inset:42px;border:1px solid #9eb5b0;background:#fbfdfc;overflow:hidden}
.frame:before{position:absolute;inset:0;background:linear-gradient(135deg,transparent 0 64%,#d7ebe6 64% 100%);content:""}
.grid{position:absolute;right:-40px;bottom:-70px;width:460px;height:360px;opacity:.7;background-image:linear-gradient(#9eb5b0 1px,transparent 1px),linear-gradient(90deg,#9eb5b0 1px,transparent 1px);background-size:36px 36px;transform:rotate(-8deg)}
.top{position:absolute;top:54px;right:62px;left:62px;display:flex;align-items:center;justify-content:space-between}
.brand{display:flex;align-items:center;gap:18px;font-weight:800;letter-spacing:.04em}.mark{display:grid;width:68px;height:68px;place-items:center;color:#fbfdfc;background:#006e60;font-family:Georgia,"Songti SC",serif;font-size:26px}.name{font-size:25px}
.index{color:#71827f;font-family:Consolas,monospace;font-size:17px;font-weight:700;letter-spacing:.12em}
.copy{position:absolute;right:62px;bottom:64px;left:62px;max-width:920px}.eyebrow{margin:0 0 22px;color:#006e60;font-family:Consolas,"Microsoft YaHei",monospace;font-size:17px;font-weight:800;letter-spacing:.11em}.title{margin:0;max-width:930px;font-family:Georgia,"Songti SC","STSong",serif;font-size:67px;line-height:1.06;letter-spacing:-.035em}.note{margin:28px 0 0;color:#536966;font-size:22px;font-weight:700}.bar{position:absolute;right:0;bottom:0;left:0;height:12px;background:#006e60}
</style></head>
<body><div class="frame"><div class="grid"></div><div class="top"><div class="brand"><span class="mark">${escapeHtml(card.mark)}</span><span class="name">Research</span></div><span class="index">${escapeHtml(card.index || 'RESEARCH / 01')}</span></div><div class="copy"><p class="eyebrow">${escapeHtml(card.eyebrow)}</p><h1 class="title">${title}</h1><p class="note">${escapeHtml(card.note)}</p></div><div class="bar"></div></div></body></html>`;
}

async function run() {
  const executablePath = resolveChrome();
  if (!executablePath) throw new Error('Chrome or Playwright Chromium is required. Set RESEARCH_CHROME when necessary.');
  fs.mkdirSync(outputRoot, { recursive: true });
  const browser = await chromium.launch({ headless: true, executablePath });
  try {
    const page = await browser.newPage({ viewport: { width: 1200, height: 630 }, deviceScaleFactor: 1 });
    for (const card of cards) {
      await page.setContent(template(card), { waitUntil: 'load' });
      await page.screenshot({ path: path.join(outputRoot, card.file), type: 'png' });
      console.log(`generated ${path.relative(repoRoot, path.join(outputRoot, card.file))}`);
    }
  } finally {
    await browser.close();
  }
}

run().catch(error => {
  console.error(error.stack || error);
  process.exit(1);
});
