# Reusable research-to-HTML prompt

Use this prompt as an execution brief. Replace bracketed values only. Do not add personal names, local machine paths, account identifiers, private repositories, tokens, customer data, or domain assumptions that are not required by the research question.

```text
Use $research-to-html to investigate the following decision and publish a bilingual static report.

Decision to support
- Decision question: [what must be decided]
- Intended reader role: [role, not a named individual]
- Geographic scope: [regions]
- Time boundary and research cutoff: [date or rule]
- Operational definitions: [define success, profit, growth, mainstream, risk, or other ambiguous terms]
- In scope: [topics]
- Out of scope: [topics]

Research requirements
1. Prefer current primary sources: regulators, official statistics, filings, platform rules/help, product documentation, direct project pages, and first-party postmortems.
2. Browse and re-verify any fact that may have changed, including prices, fees, laws, policies, rankings, availability, leadership, product status, and platform rules.
3. For every decision-changing claim, record the direct URL, source type, observed date, geography, caveat, and confidence.
4. Separate direct observation, interpretation, and unknowns.
5. Look for failed, delayed, discontinued, or contradictory cases. Do not use only visible winners.
6. Do not treat revenue-like metrics as profit or funding success as delivery.
7. If evidence is unavailable, say what could not be verified and how that limits the decision.

Required outputs
- A reviewable Markdown research source containing scope, method, findings, evidence, limitations, decision criteria, actions, and direct sources.
- index.html as the English canonical report.
- index.zh-CN.html as the Simplified-Chinese equivalent.
- A top language switch on both pages.
- Browser or system locale detection on the canonical entry; use English when no supported locale is detected.
- Persist an explicit locale choice across reports when local storage is available.
- Shared CSS and shared behavior; do not duplicate the visual system into each report.
- A brief layer containing the decision, key evidence, main caveat, and action; a full layer containing methods, comparison detail, cases, and sources.
- Update the repository catalog and concise English/Chinese project documentation when applicable.

HTML quality contract
- Lead with a specific, evidence-bounded finding rather than a generic report title.
- Use semantic HTML, one h1, one main, ordered heading levels, labels for controls, table captions and scopes, visible focus, and text labels in addition to color.
- Keep the complete report readable without JavaScript.
- Use interactions only when they lower comprehension cost.
- Support 320–1440px layouts, keyboard use, reduced motion, dim mode, print, and deep links.
- Keep citations near the claims they support and preserve research caveats in both languages.

Validation and handoff
- Run the repository's validation script when present.
- Check both locale pages for parity, local asset paths, duplicate IDs, broken anchors, console errors, responsive overflow, and interactive outputs.
- Review the exact diff and include only task-scoped files.
- Report the research cutoff, output files, locale behavior, validation results, evidence gaps, and publication state.
```

If the repository already defines a stricter research, visual, localization, or Git contract, follow it in addition to this prompt.
