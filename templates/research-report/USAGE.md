# Using the report template

**English** · [简体中文](USAGE.zh-CN.md)

Choose a stable public English slug. Copy the Markdown templates to `reports/<report-slug>/` and the HTML templates to `site/<report-slug>/`.

1. Complete and review the two Markdown evidence sources under `reports/<report-slug>/`.
2. Replace bracketed content in both public pages under `site/<report-slug>/`.
3. Keep conclusions, figures, caveats, sources, and interactive thresholds aligned across languages.
4. Replace every `example.invalid` URL, add the production share image and JSON-LD, switch `noindex,nofollow` to the approved index/follow directive, and update absolute canonical, reciprocal `hreflang`, counterpart links, contents, and section IDs.
5. Keep the imports of `../assets/i18n.js`, `../assets/research.css`, and `../assets/research.js`.
6. Add `report.js` only for genuinely report-specific behavior.
7. Add the exact reader-facing files to `public-site.json`, then update both root README languages, catalog pages, and `site/sitemap.xml`.
8. Run the repository validation script.

Do not copy shared CSS into a report, change public component classes for one-page skinning, add facts unsupported by the research source, or hide a caveat that could change the decision.

The shared system already supports calculators, filters, scorecards, flows, timelines, tables, and details. Use them only when they reduce comprehension cost.
