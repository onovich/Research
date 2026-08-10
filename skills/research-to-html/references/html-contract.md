# Bilingual HTML delivery contract

## Deliverables

For each report, prefer this structure:

```text
<report-slug>/
├─ README.md              # reviewable research source
├─ index.html             # English canonical report
├─ index.zh-CN.html       # Simplified-Chinese report
└─ report.js              # optional, report-specific behavior only
```

At repository level, reuse shared assets when available:

```text
assets/
├─ research.css           # tokens, layout, components, responsive, print
├─ i18n.js                # locale detection, persistence, routing, common strings
└─ research.js            # reading shell and optional research tools
```

Do not copy shared CSS into report directories.

## Locale contract

- Make English the canonical file and unsupported-locale fallback.
- Provide a Simplified-Chinese counterpart with the same conclusions, figures, caveats, links, and interactive model.
- Put an EN / 中 selector in the top header of every page.
- On canonical entry, inspect stored preference first, then `navigator.languages`, then `navigator.language`; use English if neither resolves to `en` or `zh`.
- Persist explicit selection with a site-scoped key when storage is available.
- Keep content available without JavaScript. Static counterpart pages are preferred for long reports because they preserve semantics, print, indexing, and failure tolerance.
- Preserve the current hash when locale routing changes pages.
- Add `hreflang` alternates for `en`, `zh-CN`, and `x-default` where practical.

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
- matching decision figures, dates, sources, and interactive thresholds;
- JavaScript syntax and zero runtime exceptions;
- 320, 375, 768, 1024, and 1440px layouts;
- keyboard navigation, deep links, dim mode, print, and no-script behavior;
- the exact repository validation command, when supplied.

Update the root catalog after adding or materially changing a report. Publish only explicitly reviewed files.
