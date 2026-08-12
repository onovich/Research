# Industry-report writing standard

Use this standard for every reader-facing report, including later revisions of an existing report. The report must read as a complete current edition for a first-time reader. Repository history, collection history, and editorial process belong in internal notes or a changelog, not in the analytical narrative.

## Benchmarks used

The following public institutional reports provide structural benchmarks. Learn from their information design and evidentiary discipline; do not copy their wording, examples, or visual identity.

| Benchmark | Practice to retain |
|---|---|
| [OECD Digital Economy Outlook 2024, Volume 1](https://www.oecd.org/en/publications/oecd-digital-economy-outlook-2024-volume-1_a1689dc5-en/full-report.html) | A reader's guide, executive summary, scoped chapters, named source groups, and a clear separation between findings and methodology. |
| [Stanford AI Index Report 2025](https://hai.stanford.edu/ai-index/2025-ai-index-report) | Finding-led takeaways supported by a number, comparison, period, and source documentation rather than slogans. |
| [World Development Report 2024](https://www.worldbank.org/en/publication/wdr2024) | Standalone main messages and chapters organized around explicit analytical questions. |
| [World Economic Forum, Future of Jobs Report 2025](https://www.weforum.org/publications/the-future-of-jobs-report-2025/in-full/) and its [methodology appendix](https://www.weforum.org/publications/the-future-of-jobs-report-2025/in-full/appendix-6d9e5fce68/) | Key findings in the report body, with survey scope, population, weighting, and methodological limits documented separately. |
| [China Academy of Information and Communications Technology, 中国数字经济发展研究报告（2024年）](https://www.caict.ac.cn/kxyj/qwfb/bps/202408/P020240830315324580655.pdf) | Explicit source databases, reference years, adjustment rules, missing-data handling, and anomaly treatment. |
| [World Bank Global Findex methodology](https://www.worldbank.org/en/publication/globalfindex/methodology) | The target population, sampling frame, sample size, geography, languages, and representativeness are stated before generalizing from the results. |

## First-read independence

Every published page must answer these questions without requiring another edition, prior conversation, or repository context:

1. What is being investigated and why?
2. What population, geography, time period, and operational definitions apply?
3. What are the principal source groups and sample sizes?
4. What are the main findings?
5. Which denominator, comparison, and method support each finding?
6. What remains unknown or cannot be generalized?

Do not write the body as a release note. Unless change over time is itself the research question, remove phrases such as:

- “the previous version,” “the original sample,” “we expanded,” “now covers,” or “after correcting the parser”;
- “上一版”“原先样本”“这次扩展”“现在覆盖”“修正后”等过程说明；
- references to what the reader supposedly already knows, requested, or saw earlier.

When an earlier and a broader sample must be compared, define both scopes in the current report and describe the comparison as a sensitivity, robustness, or coverage test. Never make the earlier edition part of the explanation.

## Opening structure

Use this order near the top:

1. concise topic title;
2. a plain-language subtitle that tells readers what the report helps them understand, optionally using one anchor number;
3. research background and purpose;
4. question, scope, cutoff, exclusions, and principal data sources;
5. three to six key findings;
6. main evidence limitation.

The subtitle is orientation, not a miniature abstract or limitation section. Give it one job and one natural sentence. It may state the main finding or the question and scope, but it must sound like something written for a person rather than a database field. Put denominators, methods, and caveats in the context and evidence-boundary blocks unless one is essential to prevent a false impression.

## General-reader test

- Write for an interested non-specialist who has not seen the brief, repository, or prior edition.
- Prefer everyday words and short sentences. Keep terms such as denominator, sensitivity test, and confidence interval in the sections that explain them.
- Let the title and subtitle answer “why should I read this?” before they answer “how was every claim qualified?”
- Do not stack a result, sample description, three caveats, and a methodological disclaimer into one sentence.
- Read the title, subtitle, and lead aloud. If they sound like metadata, an academic abstract, or a compliance notice, rewrite them.

## Analytical register

Use a plain professional register:

- prefer “the data show,” “the sample contains,” “the estimate is sensitive to,” “the evidence does not establish,” and their direct Chinese equivalents;
- use “case review” or “案例核查” unless the evidence was actually audited;
- distinguish displayed, self-reported, recalculated, estimated, audited, and verified values;
- state the result first, evidence second, bounded interpretation third, and material limitation last;
- use paragraphs of one idea and usually two to four sentences;
- use headings that state findings rather than conversational questions when the answer is already known.

Avoid:

- slang, empty promotion, or overclaiming such as “obviously,” “this proves,” or “guaranteed.” Familiar phrases such as “赚钱” or “make money” are acceptable when they match the reader's question, but the body must define whether the evidence measures revenue, profit, or another outcome;
- moral framing, generic advice, rhetorical questions, metaphors, jokes, and adversarial verbs;
- process narration, self-congratulation, and commentary on how much more work the current edition contains;
- “audit” for founder interviews, page reviews, or researcher checks that are not formal audits.

## Evidence paragraph template

```text
Finding: state the evidence-bounded result.
Measure: give the value, numerator/denominator, period, unit, and comparison.
Interpretation: explain the narrow implication.
Limit: name the missing evidence or scope condition that could change the reading.
```

Not every paragraph needs four sentences, but all four functions must be recoverable nearby.

## Revision handling

When revising a published report:

1. update the title, subtitle, context, findings, methods, and limits so the edition is internally complete;
2. convert sample changes into current methodological definitions or robustness tests;
3. move revision history to Git, a changelog, or a dated update note outside the analytical flow;
4. search both locales for backward references and casual process language;
5. verify that a reader landing directly on either locale can understand every comparison.

Historical change may remain in the report only when the change itself is evidence, such as a time series, policy revision, or market transition. In that case, state the compared dates and measures explicitly rather than referring to “before” or “the old version.”
