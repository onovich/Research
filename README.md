# Research

**English** · [简体中文](README.zh-CN.md)

Evidence-backed Go/No-Go research for independent creators and small teams. Research turns current data into practical conclusions, then publishes them as polished, bilingual web reports with low reading pressure.

The first topic cluster covers indie-game funding, distribution, and crowdfunding economics.

[Browse the research library](https://research.onovich.com/) · [Use the AI workflow](https://research.onovich.com/tools/research-to-html/)

## Reports

- [Crowdfunding products and indie games](https://research.onovich.com/crowdfunding-and-indie-games-research/) · [中文](https://research.onovich.com/crowdfunding-and-indie-games-research/index.zh-CN.html)
  The pillar report: product profit structures, platform fit, the indie-game channel decision, and a 90-day validation plan.
- [Which indie game genres fit crowdfunding?](https://research.onovich.com/indie-game-crowdfunding-genres-and-gameplay/) · [中文](https://research.onovich.com/indie-game-crowdfunding-genres-and-gameplay/index.zh-CN.html)
  The game-specific deep dive: current platform samples, seven audience/gameplay patterns, released cases, failure modes, platform routes, and the ten-point fit card.

These pages share an evidence base but not detailed sections. The first supports the overall crowdfunding and channel decision; the second is the single detailed home for game genre and gameplay fit.

## Use it with AI

Open this repository in Codex or another Agent Skills-compatible assistant, then ask:

> Use `$research-to-html` to research **[your decision question]** and create a bilingual web report.

When the report is ready:

> Use `$research-to-github-pages` to validate and publish it.

The main entry is [`research-to-html`](.agents/skills/research-to-html/SKILL.md). [`research-to-github-pages`](.agents/skills/research-to-github-pages/SKILL.md) is the optional publishing step. If your assistant does not discover repository skills automatically, open the linked `SKILL.md` directly.

## Repository map

- `site/` — the only source tree copied into the public Pages artifact
- `reports/` — reviewable Markdown research sources; never deployed
- `templates/` — reusable report starters; never deployed
- `.agents/skills/` — the AI research and publishing workflows
- `scripts/` — privacy, SEO, build, and browser checks
- `docs/` — workflow, architecture, and visual-system documentation

See [repository architecture](docs/repository-architecture.md) for the source/public boundary and page roles.

## License

Code, skills, scripts, and templates use the [MIT License](LICENSE). Original report text and visuals use [CC BY 4.0](CONTENT-LICENSE.md). Third-party material keeps its original rights.
