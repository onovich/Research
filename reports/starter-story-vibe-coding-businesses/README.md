# Starter Story online business study

**Subtitle:** We examined 349 public projects to see which online businesses report higher revenue and which are more practical for small teams using AI.

**English** · [简体中文](README.zh-CN.md) · [English HTML](../../site/starter-story-vibe-coding-businesses/index.html) · [中文 HTML](../../site/starter-story-vibe-coding-businesses/index.zh-CN.html)

> Research cutoff: 2026-08-12 (China Standard Time)<br>
> Geography: global, English-language businesses visible on Starter Story<br>
> Question: which visible business patterns report meaningful revenue, and which delivery structures are compatible with a fully online, AI-assisted development workflow?<br>
> Excluded from the technical-fit case review: inventory-led commerce, local delivery, regulated products, and businesses whose revenue mainly scales with human labor.

## Research context

- **Background:** Starter Story is a case library centered on businesses that report revenue. It can show which business forms and revenue records are publicly displayed, but it does not represent all startup attempts.
- **Purpose:** This report examines three questions: what revenue distribution appears in the public pages; how much profit evidence is available; and which business structures can be delivered entirely online and are technically compatible with AI-assisted development.
- **Main sources:** Starter Story's live sitemap and homepage, all 40 sitemap-listed public data pages, eight founder interviews, current product sites, the recalculated [`analysis.csv`](analysis.csv), and the 40-page aggregate [`category-summary.csv`](category-summary.csv).

## Key findings

### Starter Story spans thousands of stories, but its public data still centers on success cases

The live sitemap contained **19,122 URLs**, including **3,264 story URLs**, **477 business URLs**, and **40 data-category pages**. The homepage described the database as **2,997+ revenue-generating projects**. The first set is a URL inventory and the second is a platform claim; neither is a denominator for attempted startups.

### Forty public category pages contain 349 distinct projects

All 40 public data pages exposed **677 public row occurrences**. Thirty-nine pages contributed parseable records; one page exposed none in its logged-out view. Deduplication by domain or record URL left **349 projects**; **292** had a parseable displayed monthly-revenue value.

Among those 292 revenue-known records:

- the 25th percentile was **$9K/month**;
- the median was **$30K/month**;
- the 75th percentile was **$113.5K/month**;
- **217 / 292 (74.3%)** displayed at least $10K/month;
- **151 / 292 (51.7%)** displayed at least $30K/month;
- **86 / 292 (29.5%)** displayed at least $100K/month;
- **13 / 292 (4.5%)** displayed at least $1M/month.

These are distributions inside a logged-out, winner-only public excerpt. They describe what is displayed, not what a new project should expect to earn.

### 36.7% of projects appear in more than one category

Cross-category duplication accounted for **328 / 677 row occurrences (48.4%)**. **128 / 349 unique projects (36.7%)** appeared on more than one data page. A project appeared on **1.94 pages on average**; the median was one, the 75th percentile was two, and the maximum was twelve. Formula Bot and Starter Story itself each appeared under twelve labels; the “solo developer” page still included a physical beverage-container company.

The category system is therefore useful for finding cases, but unsafe for adding counts, estimating market share, or treating a category median as a pure business-model median.

### Expanding to all 40 public categories lowers the monthly-revenue median from $40K to $30K

To test whether page selection changes the result, the report uses two comparable scopes: a ten-page thematic subset directly related to online software, and all 40 sitemap-listed public data pages. Under the same parsing and deduplication rules, the ten-page subset contains **148 unique projects**, **127 revenue-known records**, and a **$40K/month** median; the 40-page family contains 349 unique projects, 292 revenue-known records, and a $30K/month median.

Relative to the ten-page subset, the 40-page family contains **135.8%** more unique projects and **129.9%** more revenue-known records, while its displayed median is **25%** lower and its duplicate-row rate rises from **21.3% to 48.4%**. This sensitivity test shows that page selection materially affects the center of the distribution; a thematic subset should not be presented as the complete public page family.

### Starter Story's Solopreneur Score is not a revenue forecast

The public excerpt contained a Solopreneur Score for **348 / 349 projects (99.7%)**. Among the **291 projects** with both a score and revenue, the Pearson correlation between the score and log monthly revenue was **−0.189**. That is a weak negative association inside a selected winner set, not evidence that lower scores cause higher revenue.

Score bands were also non-monotonic: the displayed revenue medians were **$85K** below 60, **$35K** from 60–69.9, **$10.5K** from 70–79.9, and **$26K** at 80 or above. The score may describe solo-operability; this excerpt does not support using it to predict revenue.

### Simpler builds can reach high revenue, but their median is lower

To ask a narrower online-build question without hand-classifying individual companies, the analysis formed three disclosed unions of page memberships. These groups still overlap and inherit the platform's editorial labels.

| Page-membership proxy | Pages in union | Unique projects | Revenue-known | Displayed P25 / median / P75 | Median solo score |
|---|---:|---:|---:|---:|---:|
| Software delivery | 13 | 159 | 135 | $8.8K / $24.8K / $92.5K | 70.8 |
| Low-complexity delivery | 7 | 90 | 73 | $6K / $19.4K / $50K | 72.7 |
| Coordination or labor-heavy online delivery | 2 | 47 | 47 | $22K / $50K / $200K | 60.0 |

The low-complexity proxy contains **15 / 73 revenue-known projects at or above $100K/month**, showing that lower implementation complexity and high displayed revenue can coexist. Its median remains below the coordination or labor-heavy proxy, which usually includes more work that is difficult to automate. Seven projects belong to both the software-delivery and coordination/labor unions, so these results describe selected successful projects rather than success rates, profit comparisons, or mutually exclusive models.

### Only three of eight reviewed cases disclose a profit margin

The eight reviewed online-software cases have a **$23K reported monthly-revenue median**. Five provide some profit evidence, but only three disclose a margin. The 40-page public sample can describe displayed revenue; it cannot supply the missing profit data.

### Online software can be delivered end to end, but AI mainly lowers the build barrier

The case evidence shows that platform workflow tools, one-job generators, mobile utilities, applications built on model APIs, API products, and plugins can be delivered as online software. Standard interface, database, payment, and external API work is compatible with AI-assisted development and may reduce some first-version implementation effort.

Technical implementation is only one part of the operating model. Distribution, retention, model cost, platform fees, parsing accuracy, security, and support affect whether displayed revenue becomes durable profit. Marketplaces and productized services can also operate online while remaining dependent on two-sided liquidity or human delivery.

## What these data actually represent

| Layer | Numerator / denominator | Result | What it supports | What it does not support |
|---|---:|---:|---|---|
| Sitemap inventory | 3,264 story URLs / 19,122 total URLs | 17.1% | The site contains thousands of story pages | A count of profitable or current businesses |
| Public data-page coverage | 40 / 40 sitemap-listed pages | 100% of this page family | Every public collection page was checked | Coverage of all Starter Story projects |
| Public category excerpt | 677 rows − 328 duplicates | 349 unique projects | The observable cross-section of the public data-page family | A random or representative platform sample |
| Revenue coverage | 292 / 349 | 83.7% | Most public excerpt projects expose a monthly-revenue field | Audited, current, or net revenue |
| Revenue distribution | 292 revenue-known projects | $9K / $30K / $113.5K P25 / median / P75 | The displayed winner distribution is wide and right-skewed | Expected income for a new project |
| Cross-category overlap | 128 / 349 unique projects | 36.7% | Labels frequently describe the same business | Mutually exclusive model comparisons |
| Solopreneur Score pairing | 291 projects with score and revenue | r = −0.189 against log revenue | The score has little linear relationship with displayed revenue here | Causal effect or revenue prediction |
| Audited case profit coverage | 5 / 8 any evidence; 3 / 8 margins | 62.5%; 37.5% | Profit evidence is sparse even in selected cases | A platform-wide profit rate |

All inputs, formulas, and scope notes are in [`analysis.csv`](analysis.csv).

## 1. Method and evidence boundary

The analysis uses five layers:

1. **Site inventory:** the public sitemap supplies URL counts, including story and data-page families.
2. **Platform aggregates:** the homepage supplies the platform's project claim and the counts and medians of 26 data-page cards visible there.
3. **Public data-page census:** the sitemap identifies all 40 public `/data/` pages; 39 contribute logged-out record cards and one contributes none.
4. **Deduplicated excerpt, score, and proxy analysis:** domains or record URLs collapse 677 page appearances into 349 projects; revenue, page membership, Solopreneur Score, and three disclosed page-label unions are analyzed only where present.
5. **Case review:** eight online-software interviews and two counterexamples supply cost, margin, churn, labor, and distribution context.

All 40 page-level aggregates are in [`category-summary.csv`](category-summary.csv). This is a census of a public page family, not a census of businesses: each page is curated, pages overlap, and their logged-out record cards are default-ordered.

### Collection boundary

The public-page collection used **42 GET requests**: one compressed sitemap, one homepage, and 40 data pages. Requests were single-threaded with a six-second interval and an identifying research user agent. There was no login, pagination guessing, retry loop, or bypass of access controls. No 403, 429, or challenge response occurred. Parsing and statistics were recalculated from the local cache without additional requests.

Starter Story's [robots file](https://www.starterstory.com/robots.txt) allows the public site except `/admin`. Its [terms](https://www.starterstory.com/terms) require a link back when data are used and restrict republication. This report therefore publishes aggregate calculations and direct links only; the row-level extraction remains local and is not part of the public repository.

### Operational definitions

| Term | Definition |
|---|---|
| Displayed revenue | Monthly revenue shown by Starter Story or stated in a founder interview. It is not independently audited. |
| Profit-evidenced | A case explicitly states profit, margin, or costs that allow a profit relationship to be checked. Revenue alone does not qualify. |
| Fully online | Product delivery, acquisition, payment, and support can occur remotely without inventory or on-site fulfillment. |
| AI-assisted build scope | A first version mainly uses standard UI, database, payment, and API work that AI coding tools can accelerate. It is a technical description, not a business score. |

## 2. Popular categories differ sharply in revenue, but often contain the same projects

The homepage exposed count and median cards for **26 of the 40** sitemap-listed data pages. Those 26 cards sum to **6,666 memberships**, not unique projects, and their displayed medians range from **$10K to $800K per month**. The high end includes editorial collections such as “Big Acquisitions”; the range is not a model ranking.

The table below focuses on collections relevant to online software or delivery structure. The full 40-page worksheet remains available in [`category-summary.csv`](category-summary.csv).

| Public collection | Displayed projects | Displayed median | Public rows | Revenue rows | Excerpt median | Median solo score |
|---|---:|---:|---:|---:|---:|---:|
| Micro SaaS | 670 | $40K | 24 | 18 | $12.17K | 75 |
| No-code | 314 | $30K | 24 | 18 | $36K | 72 |
| Simple apps | 241 | $20K | 11 | 10 | $35.65K | 75 |
| Solo developers | 237 | $40K | 24 | 22 | $88.5K | 80 |
| GPT wrappers | 148 | $30K | 24 | 19 | $16K | 77 |
| Weekend projects | 135 | $30K | 11 | 8 | $15.5K | 80 |
| APIs | 54 | $80K | 11 | 10 | $37.4K | 68 |
| Chrome extensions | 3 | $20K | 3 | 3 | $20K | 78 |
| Plugins | 19 | $30K | 11 | 10 | $29.5K | 76 |
| Consumer iOS apps | 79 | $40K | 11 | 10 | $21K | 78 |
| Freemium and open source | 157 | $30K | 24 | 22 | $25.5K | 69 |
| Automation | not shown | not shown | 24 | 21 | $83K | 71 |
| One-page websites | not shown | not shown | 24 | 23 | $14K | 71 |
| Marketplaces | 285 | $200K | 24 | 24 | $108.5K | 59 |
| Productized services | 549 | $40K | 24 | 24 | $48.5K | 68 |

The displayed median and excerpt median use different denominators. The first comes from a platform card for its full curated collection; the second comes only from logged-out record cards. The “solo developer” excerpt median is high partly because the label contains non-software and non-solo-shaped businesses. The “automation” excerpt also mixes compact tools with large organizations. The numbers describe tagged case collections, not mutually exclusive industries.

## 3. Revenue is not profit

| Case | Public figure used | Profit evidence | Commercial mechanism |
|---|---|---|---|
| [Data Fetcher](https://www.starterstory.com/stories/how-i-built-it-23k-month-micro-saas) | $23K MRR; 600 paying customers | 85% margin stated; hosting about $2.5K/mo and tools about $1K/mo | Airtable marketplace, repeated API imports, integration content |
| [Supergrow](https://www.starterstory.com/stories/how-i-made-65k-in-3-days) | $65K lifetime-deal launch; later $19K+/mo | 60–70% margin stated | Existing audience, affiliates, validated category, weekend MVP |
| [ChartDetector](https://www.starterstory.com/stories/i-make-50k-per-month-working-5-hours-a-week) | April revenue $43.7K; about $50K/mo | About $11.5K profit; 25% stated margin | Paid TikTok acquisition, hard paywall, ad creative, Apple fees |
| [Formula Bot](https://www.starterstory.com/stories/excelformulabot) | $23K in the reported month | Profitable stated; no margin | One Excel job, early category position, influencers, SEO |
| [Bank Statement Converter](https://www.starterstory.com/stories/bankstatementconverter) | $12.5K MRR; $126,218 trailing-12-month revenue | Profitable after stopping ads; no margin | Search demand, accountant use, parsing accuracy, support |
| [Profit AI](https://www.starterstory.com/stories/i-turned-this-spreadsheet-into-a-30k-month-micro-saas) | $30K app MRR plus nearly $40K service MRR | No net-profit figure used | Consulting workflow converted to Shopify software; churn remains |
| [Erly](https://www.starterstory.com/stories/this-insanely-simple-app-makes-50k-month) | $50K/mo and 200K+ downloads stated | No profit figure used | Narrow mobile outcome, subscriptions, UGC, influencers |
| [SiteGPT](https://www.starterstory.com/stories/sitegpt) | About $15K MRR | No profit figure; model costs uncertain | 2–3 week MVP, launch audience, nearly 50% first-month churn |

### Two cost-disclosing software businesses differ by nearly 60 margin points

| Case | Calculation | Result | Bounded reading |
|---|---|---:|---|
| Data Fetcher | known costs 3,500 / revenue 23,000 | 15.2% known cost share | Broadly consistent with the founder's stated 85% margin; labor and tax remain excluded |
| ChartDetector | profit 11,500 / revenue 43,700 | 26.3% margin | Paid acquisition and platform fees consumed roughly three quarters of revenue |
| Bank Statement Converter | current 12,500 / TTM monthly average 10,518 − 1 | +18.8% | Current MRR exceeded the historical monthly average; this is not a profit measure |

Two counterexamples keep the interpretation bounded. [DealA](https://www.starterstory.com/stories/deala) reported more than $250K invested for roughly $2K monthly profit and negative ROI. [Antropy](https://www.starterstory.com/stories/antropy) reported a record monthly profit above £30K, but with a five-person agency team. Both are online; neither shows that a small codebase produces a low-labor asset.

## 4. Eight business structures can be delivered online, but their operating burdens differ

| Business structure | Observed evidence | Build layer | Dominant evidence gap outside the build |
|---|---|---|---|
| Platform workflow tool | Data Fetcher: $23K/mo, 600 paid accounts, 85% stated margin | Standard UI, database, payments, and external APIs | Store conversion, platform dependence, integration support |
| One-job generator | Formula Bot: $23K/mo, profitable stated, no margin | Narrow input-output workflow plus inference or rules | Repeat use, inference cost, SEO durability |
| Mobile utility | ChartDetector: 26.3% recalculated margin; Erly: $50K/mo, no profit | Mobile UI, subscriptions, analytics, store integration | Paid acquisition, app-store fees, cohort retention |
| AI support wrapper | SiteGPT: $15K MRR and roughly 50% first-month churn | Data ingestion, chat UI, model and vector APIs | Model cost, answer quality, churn, support |
| API or plugin | API card median $80K on 54 cases; plugin median $30K on 19 | Endpoint or host-platform integration | Reliability, security review, platform changes, small denominators |
| Marketplace | Card median $200K; excerpt median $108.5K | The website is buildable with standard components | Two-sided liquidity, trust, disputes, operations, take rate |
| Productized service | Card median $40K; Antropy used five people | Software can standardize intake and delivery | Labor per revenue unit, utilization, customer concentration |
| Sensitive-document automation | Bank Statement Converter: $12.5K MRR and ongoing parsing support | Upload, extraction, conversion, billing | Security, document variance, exception handling, compliance |

The data support a narrow technical conclusion: AI-assisted tools can reduce the effort needed to produce a first version of several online software shapes. They do not show that AI improves demand, retention, reliability, or profit.

## 5. Evidence boundaries

| Missing evidence | Why it changes the reading |
|---|---|
| Failed-project denominator | A library of revenue-generating projects cannot estimate the probability that an attempt reaches the displayed scale |
| Random sampling | Default public rows are curated and ordered by the platform; their percentiles are descriptive only |
| Current verifiable profit | Founder interviews use different dates and definitions; only 3 of 8 reviewed cases disclose a margin |
| Mutually exclusive categories | 36.7% of unique excerpt projects appear on multiple data pages; 328 of 677 row occurrences are duplicate project appearances |
| Stable category ranking | The ten-page thematic subset and 40-page family have medians of $40K and $30K respectively, showing that page selection changes the result |
| Revenue-predictive solo score | The score/log-revenue correlation is only −0.189 in this selected excerpt, and score-band medians are non-monotonic |
| Founder labor and support | Revenue rarely includes unpaid founder time, exception handling, maintenance, or customer support |
| Causal effect of AI coding | Cases show coexistence between AI use and shipped products, not the effect of AI on revenue or quality |
| Distribution transferability | An audience, marketplace position, search ranking, affiliate launch, or ad model may be specific to one case |
| Long-term retention | Most interviews provide point-in-time revenue, not comparable cohort or net-retention data |

## 6. Evidence ledger

| Source | Type | Observation used | Confidence and limit |
|---|---|---|---|
| [Starter Story sitemap](https://www.starterstory.com/sitemap) | First-party site inventory | 19,122 URLs, 3,264 story URLs, 477 business URLs, 40 data pages | High for the cutoff snapshot; URL counts are not business or profit counts |
| [Starter Story homepage](https://www.starterstory.com/) | First-party live display | 2,997+ project claim, category counts, and medians | Medium; platform-defined, overlapping, self-reported winner library |
| [All 40 public data pages](category-summary.csv) | First-party public excerpt; source URLs in CSV | 677 row occurrences, 349 unique projects, 292 revenue fields | Medium for displayed records; complete page-family coverage but default-ordered, non-random, selected winners |
| [Starter Story terms](https://www.starterstory.com/terms) and [robots](https://www.starterstory.com/robots.txt) | First-party access boundary | Linkback and republication constraints; public crawl rules | High for the cutoff; terms can change |
| [Eight case interviews](https://www.starterstory.com/stories/how-i-built-it-23k-month-micro-saas) | Founder interviews | Revenue, profit, margin, costs, churn, distribution, and build details | Medium; self-reported, different dates, not audited |
| [Official product sites](https://datafetcher.com/) | First-party product pages | Selected products still had a public offer at the cutoff | High for availability; no independent financial verification |

Additional current product checks: [Profit AI](https://tryprofit.ai/), [Formula Bot](https://www.formulabot.com/), [SiteGPT](https://sitegpt.ai/), [Bank Statement Converter](https://bankstatementconverter.com/), [Supergrow](https://www.supergrow.ai/), and [ChartDetector](https://chartdetectorai.com/).

## Conclusion

Starter Story's public pages show that several online business forms have reported substantial revenue. The 40 data pages contain 349 deduplicated projects; among the 292 with a revenue field, the displayed monthly-revenue median is $30K. As a robustness test, the ten-page thematic subset has a $40K median; the full-page-family median is 25% lower, showing that page selection materially affects the result.

Profit is the main evidence gap. Of the eight reviewed online-software cases, five provide some profit evidence and only three disclose a margin; Data Fetcher offers the most complete evidence because it combines revenue, paid accounts, named costs, and a stated margin. The available data support the descriptive conclusion that multiple online business forms have generated revenue, but they do not support comparisons of success probability, current net profit, or suitability for a particular operator.
