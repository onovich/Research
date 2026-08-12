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

- Use a unique, concise, query-descriptive title, meta description, and visible `h1` for each page.
- On report pages, put a plain-language, reader-oriented `.report-subtitle` directly after the `h1`, and mirror it in Article `alternativeHeadline` structured data. The subtitle may state the finding or the question and scope; it must not read like a compressed abstract or disclaimer stack.
- Add an absolute HTTPS canonical, `index,follow` directive, favicon, Open Graph fields, Twitter Card fields, and valid JSON-LD using a public organization or intentional author identity.
- Keep the title and `h1` natural. Do not repeat keywords or claim outcomes the evidence does not establish.
- Publish an XML sitemap containing exactly the canonical public locale URLs and their reciprocal alternates.
- Add reader-facing method, transparency, correction, and update information through shared trust pages or visible report sections.
- Keep 404 pages useful and `noindex`.
- Build the deployed site from an explicit allowlist. Do not expose README files, evidence notebooks, docs, skills, scripts, templates, hidden directories, local configuration, or repository internals through the Pages artifact.

## Information hierarchy

1. Open with a concise topic title followed by one natural sentence explaining what the report helps a general reader understand.
2. Before the conclusion, show a compact research-context block with three plainly labeled items: background, the specific answer sought, and the main source groups.
3. Keep the brief layer sufficient for understanding: conclusion, decisive evidence, main caveat, and material unknowns.
4. Put detailed tables, cases, method, and full sources in the full layer.
5. Give the judgment before supporting detail in every section.
6. Keep the research cutoff and limitations visible.

Every locale page must be a standalone current edition. Do not use the hero, headings, section intros, captions, callouts, or metadata to narrate an earlier version, expanded collection, corrected parser, or what the reader supposedly saw before. If two sample scopes are analytically relevant, define both on the page and label the comparison as a sensitivity, robustness, or coverage test.

Use a plain professional register in visible prose and metadata. Prefer familiar words, finding-led headings, and neutral evidence verbs. Do not confuse professional tone with bureaucratic compression. Avoid empty promotion, rhetorical devices, release-note language, and “audit” unless a formal audit occurred.

In findings, analysis, comparisons, and callouts, make every heading state a reader-facing result rather than the research workflow. Proxy definitions, parsing steps, page-selection tests, calculations, and caveats belong in the supporting copy or the explicit method and limitations layers. If one of those conditions materially changes the result, put the measured change in the heading instead of naming the technique.

Use ledgers for relationships, answer stacks for research or decision questions, evidence strips for two to four decisive numbers, callouts for caveats, definition rows for mappings, ranked lists only for justified priority, tables for exact comparison, and timelines only for real sequence.

For data-bearing reports, include at least one data-insight block with:

- a headline that states the finding rather than the topic;
- the raw values, unit, period, and comparison baseline;
- a compact bar, table, or other accessible comparison when it materially reduces reading effort;
- the derived result and formula or a link to its evidence worksheet;
- a nearby caveat that prevents overgeneralization.

Do not use decorative charts. Do not encode meaning only in color. A ranking must expose its comparable inputs and rule; otherwise present it as a hypothesis or experiment backlog.

## Interaction boundary

Allowed when useful:

- reading depth, larger text, dim theme;
- contents and reading position;
- focused data filters;
- scenario or cost calculators;
- evidence filters or calculators whose inputs and formulas come from the research;
- ordered flows, timelines, and print mode.

Do not use motion to carry essential meaning. Respect reduced-motion preferences. Never hide a caveat that could reverse the conclusion.

Do not add project roadmaps, validation timelines, “what to build” modules, action scorecards, or generic next steps to a research report. A report must not presume that its reader will execute a project. If the user explicitly requests advice, publish it as a separate companion artifact outside the report and label evidence, inference, and value judgment.

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
- matching key figures, dates, sources, and interactive thresholds;
- matching numerators, denominators, formulas, units, comparison periods, and derived results;
- first-read independence: no conclusion or comparison depends on a prior version, conversation, or undocumented sample;
- general-reader register: title, subtitle, lead, and headings sound natural when read aloud and do not resemble metadata, an academic abstract, or a compliance notice;
- heading-only outline: analytical headings and callout titles, read without body text, communicate the report's main subject-matter findings rather than the research process;
- every brief-layer conclusion is supported nearby or explicitly labeled as inference;
- JavaScript syntax and zero runtime exceptions;
- 320, 375, 768, 1024, and 1440px layouts;
- keyboard navigation, deep links, dim mode, print, and no-script behavior;
- privacy scanning of tracked content, the exact public artifact, and reachable history when sanitizing an existing repository;
- the exact repository validation command, when supplied.

Update the root catalog after adding or materially changing a report. Publish only explicitly reviewed files.
