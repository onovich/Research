# Using the report template

**English** · [简体中文](USAGE.zh-CN.md)

Choose a stable public English slug. Copy the Markdown templates to `reports/<report-slug>/` and the HTML templates to `site/<report-slug>/`.

1. Complete and review the two Markdown evidence sources under `reports/<report-slug>/`.
2. Open both Markdown and HTML versions with a short research context: background, the specific answer sought, and the main data sources.
3. Replace bracketed content in both public pages under `site/<report-slug>/`; keep the title short and put the central finding in the subtitle field.
4. Keep findings, figures, caveats, sources, and interactive thresholds aligned across languages.
5. Replace every `example.invalid` URL, add the production share image and JSON-LD, switch `noindex,nofollow` to the approved index/follow directive, and update absolute canonical, reciprocal `hreflang`, counterpart links, contents, and section IDs.
6. Keep the imports of `../assets/i18n.js`, `../assets/research.css`, and `../assets/research.js`.
7. Add `report.js` only for genuinely report-specific behavior.
8. Add the exact reader-facing files to `public-site.json`, then update both root README languages, catalog pages, and `site/sitemap.xml`.
9. Run the repository validation script.

Do not copy shared CSS into a report, change public component classes for one-page skinning, add facts unsupported by the research source, hide a caveat that could change the conclusion, or assume the reader intends to build or operate a project.

The shared system supports evidence filters, calculators, chronological timelines, tables, and details. Use them only when they reduce comprehension cost. Never add a validation plan, roadmap, project brief, action scorecard, or generic next steps to the research report. If the user explicitly asks for advice, create a separate companion artifact and keep it outside the report.
