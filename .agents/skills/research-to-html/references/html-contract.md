# Bilingual HTML delivery contract

## Deliverables

When the repository separates review sources from its public site, prefer this structure:

```text
reports/<report-slug>/
├─ README.md              # reviewable English research source
└─ README.zh-CN.md        # reviewable Simplified-Chinese source

site/<report-slug>/
├─ index.html             # English canonical report
├─ index.zh-CN.html       # Simplified-Chinese report
└─ report.js              # optional, report-specific behavior only
```

At repository level, reuse shared assets when available:

```text
site/assets/
├─ research.css           # tokens, layout, components, responsive, print
├─ i18n.js                # explicit locale choice, persistence, common strings
└─ research.js            # reading shell and optional research tools
```

If the repository has no separated public source tree, colocating the Markdown and HTML under one report slug is an acceptable fallback. Follow the repository's established build boundary. Do not copy shared CSS into report directories.

## Locale contract

- Make English the `x-default` entry and unsupported-locale fallback. Give each language page its own canonical URL.
- Provide a Simplified-Chinese counterpart with the same conclusions, figures, caveats, links, and interactive model.
- Put an EN / 中 selector in the top header of every page.
- Use crawlable counterpart links and let the reader choose the language. Do not auto-redirect an indexable URL from browser or system language.
- Persist explicit selection with a site-scoped key when storage is available, but never use it to make a crawler-visible URL unstable.
- Keep content available without JavaScript. Static counterpart pages are preferred for long reports because they preserve semantics, print, indexing, and failure tolerance.
- Preserve the current hash when a reader follows the locale control if the implementation supports it.
- Add fully qualified, reciprocal `hreflang` alternates for `en`, `zh-CN`, and `x-default` on every indexable locale page.

## Search and public-surface contract

- Use a unique, query-descriptive title, meta description, and visible `h1` for each page.
- Add an absolute HTTPS canonical, `index,follow` directive, favicon, Open Graph fields, Twitter Card fields, and valid JSON-LD using a public organization or intentional author identity.
- Keep the title and `h1` natural. Do not repeat keywords or claim outcomes the evidence does not establish.
- Publish an XML sitemap containing exactly the canonical public locale URLs and their reciprocal alternates.
- Add reader-facing method, transparency, correction, and update information through shared trust pages or visible report sections.
- Keep 404 pages useful and `noindex`.
- Build the deployed site from an explicit allowlist. Do not expose README files, evidence notebooks, docs, skills, scripts, templates, hidden directories, local configuration, or repository internals through the Pages artifact.

## Information hierarchy

1. Open with a specific central finding.
2. Keep the brief layer sufficient for a decision: conclusion, decisive evidence, main caveat, and next action.
3. Put detailed tables, cases, method, and full sources in the full layer.
4. Give the judgment before supporting detail in every section.
5. Keep the research cutoff and limitations visible.

Use ledgers for relationships, answer stacks for decision questions, evidence strips for two to four decisive numbers, callouts for caveats, definition rows for mappings, ranked lists for justified priority, tables for exact comparison, and timelines only for real sequence.

## Interaction boundary

Allowed when useful:

- reading depth, larger text, dim theme;
- contents and reading position;
- focused data filters;
- scenario or cost calculators;
- decision scorecards;
- ordered flows, timelines, and print mode.

Do not use motion to carry essential meaning. Respect reduced-motion preferences. Never hide a caveat that could reverse the decision.

## Accessibility and resilience

- one `h1` and one `main`;
- ordered headings;
- native controls with labels;
- keyboard-operable navigation and visible focus;
- text labels in addition to color;
- table captions and correct header scope;
- no page-level horizontal overflow at 320px;
- localized control labels and live status text;
- complete readable content with JavaScript disabled;
- full content and expanded details when printing.

## Validation

Check at minimum:

- HTML structure, duplicate IDs, internal anchors, and local assets;
- an English/Chinese counterpart for every published HTML page;
- correct top language links and `lang` values;
- unique titles and descriptions, absolute canonical and reciprocal `hreflang`, social metadata, valid JSON-LD, and sitemap parity;
- matching decision figures, dates, sources, and interactive thresholds;
- JavaScript syntax and zero runtime exceptions;
- 320, 375, 768, 1024, and 1440px layouts;
- keyboard navigation, deep links, dim mode, print, and no-script behavior;
- privacy scanning of tracked content, the exact public artifact, and reachable history when sanitizing an existing repository;
- the exact repository validation command, when supplied.

Update the root catalog after adding or materially changing a report. Publish only explicitly reviewed files.
