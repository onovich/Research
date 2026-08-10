# Research

[English](README.md) · **简体中文**

一个面向决策的双语行业调研库。每份调查同时保留可复核的 Markdown 事实源，以及低阅读压力的英文、简体中文 HTML 报告。

## 调查

- [众筹商品与独立游戏专项调查](crowdfunding-and-indie-games-research/index.zh-CN.html) · [English](crowdfunding-and-indie-games-research/index.html)<br>
  调查众筹商品的盈利结构、平台差异，以及独立游戏利用众筹获得资金和宣发的成立条件。截点：2026-08-10。

可从[调查目录](index.zh-CN.html)进入统一阅读界面。

## 创建新报告

使用 [`$research-to-html`](skills/research-to-html/SKILL.md)，把决策问题转成带来源的 Markdown 事实源和双语 HTML。skill 已包含证据、脱敏、国际化、无障碍和发布质量门，与具体行业及个人身份解耦。

可复制的双语页面位于 [`research-template/`](research-template/USAGE.zh-CN.md)。

## 发布报告

使用 [`$research-to-github-pages`](skills/research-to-github-pages/SKILL.md) 验证静态站点、安装 GitHub Pages 官方 Actions workflow、监控部署，并检查线上报告路径和资源。仓库的 Pages 发布源需要设为 **GitHub Actions**。

## 共享系统

- [`assets/research.css`](assets/research.css)：视觉令牌、布局、组件、响应式与打印。
- [`assets/i18n.js`](assets/i18n.js)：语言探测、英文兜底、偏好持久化与页面跳转。
- [`assets/research.js`](assets/research.js)：阅读深度、字号、主题、目录与可选研究工具。

修改 `assets/research.css` 的语义令牌，即可批量更换全部报告的视觉皮肤。

## 规范

- [从调研到 HTML](docs/research-to-html-workflow.zh-CN.md) · [English](docs/research-to-html-workflow.md)
- [视觉系统](docs/visual-system.zh-CN.md) · [English](docs/visual-system.md)

发布前运行：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/Validate-ResearchSite.ps1
```

可选的浏览器验收脚本位于 `scripts/Smoke-ResearchSite.cjs`，需要 Playwright 与 Chrome/Chromium。
