# Research-to-HTML workflow

**English** · [简体中文](research-to-html-workflow.zh-CN.md)

Version 1.1.0 · For decision-oriented research across industries, products, markets, platforms, business models, and technical ecosystems.

## Output contract

Every study has two coupled layers:

1. `README.md` is the evidence source: question, scope, findings, reasoning, limits, and direct citations.
2. `index.html` and `index.zh-CN.html` are the English and Simplified-Chinese reading interfaces.

HTML may reorganize information. It may not strengthen a finding, hide a decision-changing caveat, alter a number, or invent evidence.

## 1. Define the decision

Before browsing, record:

- the decision and intended reader role;
- geography, language, category, and time boundary;
- operational definitions for words such as success, profit, growth, or mainstream;
- the research cutoff and likely shelf life;
- explicit exclusions.

Rewrite the topic into three to seven answerable questions. For commercial outcomes, separate public scale, process success, fulfillment, and actual business results.

## 2. Build an evidence ledger

Prefer sources in this order:

1. law, regulators, government, filings, audited reports, official statistics;
2. platform rules, help centers, pricing, product documentation, and direct project pages;
3. first-party creator, developer, or company postmortems;
4. reputable research institutions and documented datasets;
5. high-quality reporting and secondary synthesis;
6. community discussion and search snippets only as leads.

For each decision-changing claim, capture the direct source, source type, observed date, geography, caveat, and confidence.

Recheck fees, policies, rankings, prices, availability, and platform state during the active study. Label live lists as cutoff snapshots. If current evidence cannot be verified, say so instead of substituting stale material.

## 3. Analyze and falsify

Write observation before inference:

```text
Observation: what the source directly establishes.
Inference: what that evidence reasonably suggests.
Limit: what remains unknown or cannot be generalized.
```

Test every core finding for causality errors, revenue presented as profit, platform-wide data applied to a niche, survivor bias, self-reported marketing treated as audit, and historical winners whose present delivery state is ignored.

Resolve conflicting definitions, periods, regions, and samples before choosing an interpretation.

## 4. Write the Markdown source

Recommended order:

1. title, cutoff, scope, and definitions;
2. one-page conclusion;
3. method and limits;
4. model, mechanism, or calculation;
5. platform, market, or competitor comparison;
6. ranked opportunities or patterns;
7. risks and counterexamples;
8. decision criteria;
9. executable next steps;
10. direct sources.

Keep one judgment per paragraph, place direct citations near claims, mark self-reports and inference, and avoid long quotations. Do not begin HTML composition before this source is reviewed.

## 5. Compose bilingual HTML

Copy `research-template/` and use a stable English slug:

```text
<report-slug>/
├─ README.md
├─ index.html
├─ index.zh-CN.html
└─ report.js        # optional; report-specific behavior only
```

Both pages import shared assets:

```html
<script src="../assets/i18n.js"></script>
<link rel="stylesheet" href="../assets/research.css">
<script src="../assets/research.js"></script>
```

English is canonical and the unsupported-language fallback. Both pages provide a top EN / 中 switch. The canonical page reads stored preference, then browser language; an explicit choice persists across reports.

The two languages must preserve the same findings, figures, caveats, source links, calculator thresholds, and decision logic. Translation may improve natural phrasing but may not change evidential strength.

### Reading hierarchy

1. Open with a specific central finding.
2. Keep conclusion, decisive evidence, main caveat, and action in the brief layer.
3. Put comparison detail, cases, method, and complete sources in the full layer.
4. Give the judgment before evidence in each section.
5. Keep the research cutoff and limits visible.

Use interactions only when they lower comprehension cost: reading depth, text size, dim mode, contents, filters, calculators, decision cards, real sequences, and print support.

## 6. Engineering acceptance

### Content

- HTML and Markdown agree on conclusions, figures, cutoff, and limits.
- English and Chinese pages have claim and interaction parity.
- External links point to direct sources.
- Unfulfilled projects are not presented as complete commercial successes.

### Structure and accessibility

- one `h1` and one `main`;
- ordered headings and labelled controls;
- keyboard-operable navigation and visible focus;
- table captions and correct header scope;
- color is never the only state signal;
- full content remains readable without JavaScript.

### Responsive and functional

Validate 320, 375, 768, 1024, and 1440px. Page-level horizontal scrolling is not allowed; wide tables may scroll inside labelled, focusable containers.

Check reading preferences, locale routing, deep links, filters, calculators, scorecards, dim mode, reduced motion, console output, and print expansion.

## 7. Publish

1. Update the root report catalog and both project README languages.
2. Run `scripts/Validate-ResearchSite.ps1`.
3. Inspect the exact diff and stage only study-related files.
4. Commit clearly and push without force.

## Definition of done

A report is complete only when the research source stands alone, both HTML languages preserve the evidence, shared assets are reused, the responsive and accessibility checks pass, no-script and print remain complete, the catalog is updated, and repository validation succeeds.
