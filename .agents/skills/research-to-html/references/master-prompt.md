# Reusable research-to-HTML prompt

Use this prompt as an execution brief. Replace bracketed values only. Do not add personal names, local machine paths, account identifiers, private repositories, tokens, customer data, or domain assumptions that are not required by the research question.

```text
Use $research-to-html to investigate the following question and publish a bilingual static report.

Question to investigate
- Research question or decision: [what must be understood, compared, tested, or decided]
- Intended reader role: [role, not a named individual]
- Geographic scope: [regions]
- Time boundary and research cutoff: [date or rule]
- Operational definitions: [define success, profit, growth, mainstream, risk, or other ambiguous terms]
- In scope: [topics]
- Out of scope: [topics]

Research requirements
1. Prefer current primary sources: regulators, official statistics, filings, platform rules/help, product documentation, direct project pages, and first-party postmortems.
2. Browse and re-verify any fact that may have changed, including prices, fees, laws, policies, rankings, availability, leadership, product status, and platform rules.
3. For every conclusion-changing claim, record the direct URL, source type, observed date, geography, caveat, and confidence.
4. Separate direct observation, interpretation, and unknowns.
5. Look for failed, delayed, discontinued, or contradictory cases. Do not use only visible winners.
6. Do not treat revenue-like metrics as profit or funding success as delivery.
7. If evidence is unavailable, say what could not be verified and how that limits the answer or decision.
8. When the question involves scale, change, frequency, profitability, prevalence, rankings, or comparisons, build a metric worksheet before synthesis. Record raw values, units, periods, numerator, denominator, formula, result, scope, caveat, and direct source.
9. For a data-bearing report, include at least three question-relevant raw measures, three reproducible derived measures, one counterexample, one data-completeness statement, and one useful comparison table or chart. If comparable data does not exist, narrow the conclusion instead of filling the report with general principles.
10. Do not rank incompatible or overlapping samples. Label researcher judgment as inference and expose the rule used.

Required outputs
- A reviewable Markdown research source containing a short opening context block, scope, method, findings, evidence, limitations, implications or unresolved questions where relevant, and direct sources.
- The opening context block must state, in plain language, the research background, the specific answer sought, and the main source groups.
- index.html as the English `x-default` report with its own canonical URL.
- index.zh-CN.html as the Simplified-Chinese equivalent.
- A top language switch on both pages.
- Crawlable manual locale links on both pages; do not auto-redirect indexable URLs from browser or system language.
- Persist an explicit locale choice when local storage is available without changing crawler-visible URL stability.
- Shared CSS and shared behavior; do not duplicate the visual system into each report.
- A brief layer containing the answer, key evidence, main caveat, and material unknowns; a full layer containing methods, comparison detail, cases, and sources.
- Update the repository catalog and concise English/Chinese project documentation when applicable.
- A reader-facing method/transparency path, correction path, useful noindex 404 page, favicon, social share image, and XML sitemap when publishing a standalone site.

HTML quality contract
- Lead with a specific, evidence-bounded finding rather than a generic report title.
- Use semantic HTML, one h1, one main, ordered heading levels, labels for controls, table captions and scopes, visible focus, and text labels in addition to color.
- Keep the complete report readable without JavaScript.
- Use interactions only when they lower comprehension cost.
- Support 320–1440px layouts, keyboard use, reduced motion, dim mode, print, and deep links.
- Keep citations near the claims they support and preserve research caveats in both languages.
- Write findings in a plain data-insight cadence: result first; number, baseline, period, and denominator next; bounded interpretation after that; material limitation last. Use this as a structural tone benchmark only and do not copy another publication's wording.
- Expose formulas and comparison inputs in the report or its evidence notebook. Use charts only when they make a real comparison easier to read.
- Treat the intended audience as a reader, not as the presumed builder or operator of a project. Never add validation plans, project briefs, implementation roadmaps, action scorecards, recommended build sequences, or generic next steps to the research report.
- If advice is explicitly requested, produce it as a separate companion artifact. Label inference and value judgments, and state the evidence gaps that could change it.
- Add a unique title and description, absolute HTTPS canonical, reciprocal absolute hreflang for en / zh-CN / x-default, index/follow directive, Open Graph, Twitter Card, and valid JSON-LD to every indexable page.
- Use an organization-level public byline unless a personal author identity is intentionally required.

Validation and handoff
- Run the repository's validation script when present.
- Check both locale pages for parity, local asset paths, duplicate IDs, broken anchors, console errors, responsive overflow, and interactive outputs.
- Build the Pages artifact from an explicit reader-facing allowlist and verify repository docs, notebooks, skills, scripts, templates, hidden files, and local configuration are absent.
- Scan tracked content, the generated artifact, and reachable history when sanitizing an existing public repository for credentials, emails, account identifiers, local paths, private URLs, and operational files.
- Review the exact diff and include only task-scoped files.
- Report the research cutoff, output files, locale behavior, validation results, evidence gaps, and publication state.
```

If the repository already defines a stricter research, visual, localization, or Git contract, follow it in addition to this prompt.
