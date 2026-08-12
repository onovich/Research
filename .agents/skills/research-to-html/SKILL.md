---
name: research-to-html
description: Research a question or decision, build a traceable evidence notebook, and publish a low-reading-pressure bilingual English/Simplified-Chinese HTML report. Use when Codex must turn current web research, market or industry analysis, product/platform comparisons, technical ecosystem research, or business-model investigation into a reviewable Markdown source plus an interactive static report.
---

# Research to HTML

Produce an evidence-led research artifact, not a source dump. It may explain a topic, compare mechanisms, test a claim, or support a decision. Keep evidence, reasoning, uncertainty, and presentation auditable from research through publication.

## Load the contract

Read these references before acting:

1. [research-protocol.md](references/research-protocol.md) for scope, source quality, evidence ledgers, analysis, and privacy.
2. [industry-report-writing.md](references/industry-report-writing.md) for first-read independence, institutional report structure, analytical tone, and revision handling.
3. [html-contract.md](references/html-contract.md) for deliverables, bilingual routing, visual hierarchy, accessibility, and validation.
4. [master-prompt.md](references/master-prompt.md) when translating a request into the reusable execution brief or when another agent needs the complete prompt.

## Workflow

1. Define the research question or decision, audience role, scope, geography, operational terms, research cutoff, and exclusions. Ask only when an unresolved choice would materially change the result.
2. Inspect the target repository before creating files. Reuse its shared CSS, locale router, reading shell, report template, and validation script when present.
3. Browse current primary sources for unstable facts. Record direct URLs, source type, observed date, geography, caveat, and confidence.
4. Separate observation, inference, and unknowns. Test survivor bias, self-reported platform claims, stale examples, and metrics that do not establish the claimed business result.
5. Build the metric worksheet before synthesis when the question involves scale, change, frequency, profitability, prevalence, rankings, or comparisons. Preserve raw values, denominator, period, unit, formula, result, source, and caveat. Calculate shares, changes, ratios, ranges, or unit economics only when the inputs are comparable.
6. Write the Markdown evidence source before designing the report. Make every edition independently understandable to a first-time reader. Open with a short research-context block that states the background, the specific answer sought, and the main source groups. Keep claims, figures, formulas, limitations, and citations independently reviewable.
7. Compose separate English and Simplified-Chinese HTML pages from the same approved findings. Repeat the short research-context block near the top of each page, before the conclusion. Preserve numerical, causal, and uncertainty parity. Give each locale a self-canonical absolute URL and reciprocal absolute `hreflang` links.
8. Add only interactions that reduce understanding cost: reading depth, contents, theme, larger text, focused filtering, evidence calculators, historical timelines, and print support. Calculators may transform disclosed inputs but must not turn researcher judgment into a recommendation. A timeline belongs only when chronology is part of the evidence; it must not become a default action plan.
9. Update the repository catalog and concise bilingual project documentation when the report is publishable.
10. Run the repository validation gate, privacy scan, SEO metadata checks, JavaScript syntax checks, responsive and keyboard checks, both locales, print, deep links, and no-script fallback. Inspect the exact public artifact, not only the source tree.
11. Review the exact diff and publish only the intended files. Never force-push or stage unrelated workspace content.

## Non-negotiable rules

- Do not infer profit from revenue, pledges, GMV, downloads, traffic, or funding success.
- Do not rank opportunities from incompatible denominators, overlapping collections, winner-only samples, or mixed periods. Show the mismatch or replace the ranking with a bounded hypothesis.
- Every executive conclusion must point to a numeric observation, a directly cited qualitative observation, or an explicit `Inference` label. Do not leave naked top-line claims.
- For data-bearing questions, include at least three question-relevant raw measures, three reproducible derived measures, one counterexample, and one explicit data-completeness statement. If the source base cannot support this, say so and narrow the conclusion instead of filling the gap with general principles.
- Show numerator and denominator for percentages, name the comparison period, preserve units, and expose formulas in the report or evidence notebook.
- Prefer a finding-led paragraph: result first, number and comparison second, bounded interpretation third, limitation last. Avoid slogans, moral framing, metaphors, and generic business advice in evidence sections.
- Write in a measured industry-report register. Prefer neutral analytical verbs and precise evidence labels. Do not use conversational, promotional, adversarial, or self-referential process language.
- Treat every published revision as a complete current edition. Do not assume the reader saw a previous version, conversation, sample, or methodology. Remove release-note language such as “previous version,” “original sample,” “expanded,” “now covers,” and “corrected parser,” together with their Chinese equivalents, unless temporal change is itself the research subject.
- When comparing a narrow and broad sample, define both in the current edition and frame the difference as a sensitivity, robustness, or coverage test. Do not narrate the collection history.
- Use “case review” or “案例核查” unless the evidence was subject to a real formal audit.
- Treat the reader as a reader, not as the presumed operator of a project. Never put a validation plan, project brief, implementation roadmap, action scorecard, recommended build sequence, or generic next steps inside the research report.
- When recommendations are explicitly requested, deliver them as a separate companion artifact, not as part of the report. Identify the evidence and value judgments behind them, and never present researcher preference as a measured result.
- Do not silently weaken caveats in the brief layer or in translation.
- Do not introduce unsupported numbers during HTML composition.
- Cite direct supporting pages, not search-result pages.
- Mark platform, vendor, or creator claims as self-reported when no independent audit exists.
- Keep real personal names, credentials, account identifiers, local paths, private URLs, and organization-specific secrets out of reusable prompts and skill resources.
- Preserve complete readable content without JavaScript.
- Keep English as `x-default`. Provide crawlable manual language links and persist explicit selection when useful; do not auto-redirect indexable pages from browser-language inference.
- Give every indexable page a unique title and description, absolute canonical and reciprocal `hreflang`, Open Graph and Twitter metadata, valid JSON-LD, favicon, internal trust links, and sitemap coverage.
- Publish Pages from an explicit reader-facing allowlist. Repository documentation, skills, scripts, templates, notebooks, hidden files, and local configuration must not enter the public artifact.
- Use a neutral organization-level byline unless a public author identity is intentionally required. Never leak local paths or private identity through content, metadata, Git history, or deployment artifacts.

## Completion report

State the research cutoff, output paths, manual locale behavior, translated surface area, public artifact boundary, privacy and SEO validation commands, unresolved evidence gaps, and publication state.
