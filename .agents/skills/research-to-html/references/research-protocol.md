# Research protocol

## 1. Frame the question or decision

Record before browsing:

- the question to answer, claim to test, comparison to make, or decision to support;
- the reader's role, expressed without personal identity;
- geography, language, category, and time boundary;
- operational definitions for ambiguous outcomes;
- the research cutoff and likely shelf life;
- explicit inclusions and exclusions.

Rewrite a broad topic into three to seven answerable questions. Each question must end in evidence, a bounded interpretation, an unresolved unknown, or an action.

For commercial outcomes, distinguish:

- public scale: revenue, GMV, pledges, downloads, traffic, or users;
- process outcome: funded, launched, delivered, adopted, or retained;
- business outcome: contribution margin, gross profit, net profit, cash flow, or repeat purchase;
- variables unavailable from public evidence.

## 2. Build the evidence ledger

Use this source order:

1. law, regulator, government, exchange filing, audited report, official statistics;
2. platform rules, help centers, pricing, product documentation, and direct project pages;
3. first-party creator, developer, or company postmortems;
4. reputable research institutions and documented datasets;
5. high-quality reporting and secondary synthesis;
6. community discussion and search snippets only as leads.

For every conclusion-changing claim, capture:

| Field | Requirement |
|---|---|
| Claim | The exact judgment supported |
| Direct source | The page that contains the evidence |
| Source type | Official statistic, self-report, project page, third-party study, and so on |
| Observed at | Access or measurement date |
| Geography | Where the evidence applies |
| Caveat | Selection bias, marketing context, missing cost, or other limit |
| Confidence | High, medium, or low with a reason |

## 3. Enforce freshness

- Recheck fees, policies, laws, rankings, prices, product state, platform access, and current roles during the active research.
- Label live lists as cutoff snapshots.
- Pair historical success cases with current delivery or operating state.
- When a current primary source cannot be found, say “not verified” instead of substituting old evidence.

## 4. Analyze and falsify

Write in this order:

```text
Observation: what the source directly establishes.
Inference: what the evidence reasonably suggests.
Limit: what remains unknown or cannot be generalized.
```

Test every major conclusion for:

- correlation presented as causation;
- revenue-like volume presented as profit;
- platform-wide data applied to a narrow segment;
- winner-only or survivorship bias;
- self-reported marketing treated as independent audit;
- historical examples whose present outcome is ignored;
- conflicting definitions, periods, regions, or samples.

Do not average conflicting evidence by default. Resolve definitions and scope first, then explain the selected interpretation.

### Quantitative analysis gate

Use this gate when the question asks what is profitable, how large, how common, what changed, which category performs better, or whether a market or platform can support a conclusion.

Before writing prose, create a metric worksheet with:

| Field | Requirement |
|---|---|
| Raw value | Preserve the source value without silent conversion |
| Unit and period | Currency, users, items, percent, month, quarter, year, or snapshot date |
| Numerator and denominator | Required for every rate, share, or coverage claim |
| Formula | A reproducible expression for every derived measure |
| Result | Sensible precision; do not imply accuracy the source lacks |
| Scope | Population, curated sample, selected cases, geography, and time window |
| Caveat | Missing costs, overlapping categories, survivorship, mixed definitions, or other limit |
| Direct source | The page containing the input value |

Minimum evidence for a data-bearing report:

- three question-relevant raw measures;
- three derived measures such as a rate, share, change, ratio, range, or unit-economics calculation;
- one counterexample or negative case;
- one explicit data-completeness statement;
- one table or compact chart that makes a real comparison easier to inspect.

These are quality gates, not quotas for padding. If comparable inputs do not exist, publish the missingness and narrow the conclusion. Never manufacture a score to simulate precision.

Reject or relabel an analysis when:

- a curated winner database is presented as a success probability;
- overlapping category counts are added together;
- a median is shown without its sample definition and denominator;
- a current run rate is compared with a historical average without naming the mismatch;
- a percentage omits its numerator or denominator;
- an opportunity ranking is mostly researcher preference;
- a causal explanation has only evidence that two facts coexist.

### Finding-led writing

Use [Our World in Data's Data Insights structure](https://ourworldindata.org/launching-data-insights) as a tone benchmark, not as text to imitate:

1. heading states the finding in plain language;
2. first sentence answers the question;
3. second sentence gives the number, baseline, period, and denominator;
4. third sentence explains the narrow implication;
5. final sentence states the limit when it could change the reading.

Keep paragraphs to one idea and usually two to four sentences. Prefer plain verbs and concrete nouns. Remove slogans, metaphors, moral judgments, and generic advice from evidence sections. Do not copy a benchmark publication's sentences, examples, or distinctive phrasing.

## 5. Write the evidence source

Use a Markdown structure that can stand alone:

1. title, cutoff, scope, and definitions;
2. one-page conclusion;
3. method and research limits;
4. metric worksheet, model, mechanism, or calculation;
5. market, platform, or competitor comparison;
6. patterns, mechanisms, or bounded opportunity hypotheses; rank only when comparable evidence and an explicit rule justify it;
7. risks, failures, and counterexamples;
8. implications, decision criteria, or unresolved questions as the topic requires;
9. executable next steps;
10. direct sources.

Place citations near figures and claims. Mark self-reported facts and researcher inference. Do not enter visual design until the research source is reviewed.

## 6. Privacy and reuse

- Use roles and neutral placeholders instead of named users or organizations in reusable instructions.
- Exclude credentials, personal contact data, account identifiers, private URLs, machine-specific paths, session state, and internal customer data.
- Preserve public names only when they are evidence required by the report itself.
- Do not carry subject-specific examples into the reusable prompt unless they teach a general failure mode.
- Use an organization-level public byline unless a personal author identity is deliberately part of the publishing strategy.
- Scan the current tracked tree, generated public artifact, and—when sanitizing an existing public repository—reachable Git history for personal emails, local paths, credentials, private URLs, and operational files.
- Keep evidence notebooks and maintenance resources in the repository when useful, but publish only a reviewed reader-facing allowlist.
