# Research

**English** · [简体中文](README.zh-CN.md)

Evidence-led, bilingual industry research designed for decisions rather than source accumulation. Each study keeps a reviewable Markdown evidence source and publishes a low-reading-pressure HTML edition in English and Simplified Chinese.

## Reports

- [Profitable crowdfunding products and indie games](crowdfunding-and-indie-games-research/index.html) · [中文](crowdfunding-and-indie-games-research/index.zh-CN.html)<br>
  Profit structures, platform fit, and the conditions under which crowdfunding can still fund or market an independent game. Cutoff: 2026-08-10.

Open the [report catalog](index.html) for the shared reading interface.

## Create a report

Use [`$research-to-html`](skills/research-to-html/SKILL.md) to move from a decision question to a sourced Markdown notebook and bilingual HTML report. The skill is domain-neutral, identity-neutral, and includes evidence, privacy, localization, accessibility, and publication gates.

The reusable page pair is in [`research-template/`](research-template/USAGE.md).

## Publish reports

Use [`$research-to-github-pages`](skills/research-to-github-pages/SKILL.md) to validate the static site, install the official GitHub Pages Actions workflow, monitor the deployment, and verify the live report routes and assets. The repository's Pages source must be set to **GitHub Actions**.

## Shared system

- [`assets/research.css`](assets/research.css): visual tokens, layout, components, responsive behavior, and print.
- [`assets/i18n.js`](assets/i18n.js): locale detection, English fallback, preference persistence, and language routing.
- [`assets/research.js`](assets/research.js): reading depth, text size, theme, navigation, and optional research tools.

Edit the semantic tokens in `assets/research.css` to reskin every report at once.

## Standards

- [Research-to-HTML workflow](docs/research-to-html-workflow.md) · [中文](docs/research-to-html-workflow.zh-CN.md)
- [Visual system](docs/visual-system.md) · [中文](docs/visual-system.zh-CN.md)

Validate before publishing:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/Validate-ResearchSite.ps1
```

The optional browser smoke is available at `scripts/Smoke-ResearchSite.cjs` and requires Playwright plus Chrome/Chromium.
