# Repository architecture

[简体中文](repository-architecture.zh-CN.md)

## Layers

```text
site/                       Public website source; mirrors deployed URLs
reports/<public-slug>/      Reviewable Markdown research sources
templates/research-report/  Reusable bilingual report starter
.agents/skills/             AI research and publishing workflows
scripts/                    Validation, build, smoke, and image tools
docs/                       Maintainer documentation
_site/                      Generated Pages artifact; never edited by hand
```

`public-site.json` is the boundary. Its `source` is `site/`; its allowlist is copied to `_site/` without exposing reports, docs, skills, templates, or scripts.

## Page roles

| Public route | Role | Primary search intent |
|---|---|---|
| `/crowdfunding-and-indie-games-research/` | Pillar report | Crowdfunding economics, product/platform fit, indie-game channel value, and the 90-day validation plan |
| `/indie-game-crowdfunding-genres-and-gameplay/` | Companion deep dive | Current game-platform snapshots, genre/gameplay patterns, released cases, failure modes, platform routes, and the fit card |
| `/tools/research-to-html/` | Main Skill product page | Turn an evidence-backed decision question into a bilingual HTML report |

The two reports are not test duplicates. They reuse one evidence foundation, but detailed ownership is exclusive: the pillar owns economics and channel validation; the companion owns the game taxonomy, cases, risks, routes, filter, and scorecard. Keep both pages and reciprocal links, but do not copy those detailed sections back into the pillar or create near-identical pages for keyword variants.

The Skill strategy has a settled answer: keep one public product page for the main `research-to-html` promise. Present `research-to-github-pages` as the optional publishing step on that page and in the README. Do not create a second near-duplicate Skill page unless real search or support data shows a distinct task that the main page cannot answer.

## Adding a report

1. Put the reviewable English and Chinese research sources in `reports/<public-slug>/`.
2. Put the paired public pages in `site/<public-slug>/`.
3. Reuse `site/assets/`; do not copy the visual system into the report.
4. Add only the reader pages and share images to `public-site.json`.
5. Update the catalog, sitemap, reciprocal links, and validation pairs.
6. Run the validation, build, and browser smoke checks before publishing.

Do not add public HTML files to the repository root.
