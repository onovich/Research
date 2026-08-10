# Research visual system

**English** · [简体中文](visual-system.zh-CN.md)

Version 1.1.0 · A low-reading-pressure, evidence-first visual system for long decision reports.

## Design position

The system is a research handbook and working ledger, not a news portal, dashboard, or marketing landing page.

It follows four rules:

1. give the judgment before inviting deeper evidence;
2. use structure rather than decoration to express hierarchy;
3. add interaction only when it helps understanding or a decision;
4. optimize for sustained reading, not first-screen impact.

The signature device is a ledger that places public indicators, necessary deductions or constraints, and the result that cannot be observed directly on one path.

## Shared assets

- `assets/research.css`: tokens, typography, layout, components, responsive rules, and print;
- `assets/i18n.js`: locale detection, English fallback, stored choice, and counterpart routing;
- `assets/research.js`: reading depth, text size, theme, mobile contents, progress, deep links, print, and optional tools;
- `research-template/`: matched English and Simplified-Chinese page skeletons.

Reports import these assets. Do not copy the public CSS into individual report directories.

## Color tokens

The default skin uses a calm mist-green paper surface.

| Role | Light value | Use |
|---|---:|---|
| page | `#EAF0EF` | Page background |
| surface | `#FBFDFC` | Reading surfaces |
| surface-muted | `#F1F6F4` | Secondary regions |
| ink | `#18302D` | Primary text |
| ink-soft | `#536966` | Secondary text |
| line | `#C8D7D3` | Dividers |
| accent | `#006E60` | Interaction and current state |
| amber | `#805600` | Warning |
| danger | `#8B3F42` | Risk and negative result |

Dim-mode values live under `html[data-theme="dim"]`. Text, links, focus, and status colors must preserve WCAG 2.1 AA contrast.

### Batch reskinning

Change only the semantic tokens in `:root` and `html[data-theme="dim"]`. Components consume tokens and never declare report-specific colors. Recheck light, dim, focus, and print contrast after any skin change.

## Type and reading measure

- Display: Songti/STSong/Noto or Source Han Serif, then `serif`.
- Body: MiSans/PingFang/Microsoft YaHei/Noto Sans CJK, then `sans-serif`.
- Data: Cascadia Code/SFMono/Consolas, then `monospace`.

Serif type is limited to high-level headings. Body text is about 16px with a generous line height and a reading width near 48rem. Large-text mode increases body copy without letting headings dominate.

## Layout

Desktop uses a 14rem sticky reading path beside one 48rem content column. Below 64rem the path becomes a drawer. Below 48rem multi-column content collapses and tables scroll locally. Below 23rem ledger rows stack.

The spacing rhythm is based on 4, 8, 12, 16, 24, 32, 48, 64, and 96px. Major sections use space and rules rather than repeated cards or heavy shadows.

## Component language

- **Thesis hero:** one evidence-bounded central finding.
- **Ledger:** observable indicator → cost or constraint → decision result.
- **Answer stack:** decision question paired with a direct answer.
- **Evidence strip:** two to four numbers that change the decision.
- **Callout:** method, warning, risk, or stop condition, always labelled in text.
- **Definition table:** exact concept or criterion mappings.
- **Ranked list:** priority justified by analysis.
- **Data table:** exact comparison with caption, scopes, and local mobile scroll.
- **Details:** supporting cases or method, never a caveat that reverses the conclusion.
- **Flow/timeline:** only for real sequence or phases.
- **Calculator/scorecard:** an explicit model with units, thresholds, defaults, and limits.

Avoid uniform card grids. Judgment, evidence, caveat, and action should look structurally different.

## Interaction and localization

- Brief/full changes evidence depth, never the conclusion.
- Standard/large text and light/dim theme persist across reports.
- The desktop contents become a focus-managed mobile drawer.
- Filters use `aria-pressed`; result counts use `aria-live`.
- Print reveals the full report and opens details.
- No-script mode keeps complete content visible.
- EN / 中 sits in the top header on every page.
- English is canonical and the unsupported-language fallback; explicit choice persists.
- Both locales translate visible controls, status text, metadata, content, and interactive output.

## Accessibility floor

Use one `h1`, one `main`, ordered headings, native controls, visible focus, text labels beyond color, labelled tables, reduced-motion support, and complete print/no-script output. Standard text contrast is at least 4.5:1.

## Versioning

HTML declares `data-system-version`.

- Patch: visual or accessibility fix with no required report migration.
- Minor: backward-compatible component or behavior.
- Major: required structure changes or removed classes.

After shared asset changes, inspect the catalog, template, and at least one real report in both languages.
