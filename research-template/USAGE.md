# Using the report template

**English** · [简体中文](USAGE.zh-CN.md)

Copy `research-template/` to the repository root and rename the directory with a stable English slug.

1. Complete and review the new `README.md` evidence source.
2. Replace bracketed content in both `index.html` and `index.zh-CN.html`.
3. Keep conclusions, figures, caveats, sources, and interactive thresholds aligned across languages.
4. Replace every `example.invalid` URL, add the production share image and JSON-LD, switch `noindex,nofollow` to the approved index/follow directive, and update absolute canonical, reciprocal `hreflang`, counterpart links, contents, and section IDs.
5. Keep the imports of `../assets/i18n.js`, `../assets/research.css`, and `../assets/research.js`.
6. Add `report.js` only for genuinely report-specific behavior.
7. Add the exact reader-facing files to `public-site.json`, then update both root README languages, catalog pages, and `sitemap.xml`.
8. Run the repository validation script.

Do not copy shared CSS into a report, change public component classes for one-page skinning, add facts unsupported by the research source, or hide a caveat that could change the decision.

The shared system already supports calculators, filters, scorecards, flows, timelines, tables, and details. Use them only when they reduce comprehension cost.
