# Online projects that make money

**Subtitle:** A site inventory, a 133-project public excerpt, and eight audited cases separate displayed revenue from profit evidence and build complexity.

**English** · [简体中文](README.zh-CN.md) · [English HTML](../../site/starter-story-vibe-coding-businesses/index.html) · [中文 HTML](../../site/starter-story-vibe-coding-businesses/index.zh-CN.html)

> Research cutoff: 2026-08-12 (China Standard Time)<br>
> Geography: global, English-language businesses visible on Starter Story<br>
> Question: which visible business patterns report meaningful revenue, and which delivery structures are compatible with a fully online, AI-assisted development workflow?<br>
> Excluded from the technical-fit audit: inventory-led commerce, local delivery, regulated products, and businesses whose revenue mainly scales with human labor.

## Research context

- **Background:** Starter Story collects businesses that already report revenue. It is useful for observing monetized patterns, but it is not a registry of all attempts.
- **Purpose:** Separate three questions that are often mixed together: what the platform displays, what its public records say about revenue and profit, and what can actually be delivered as online software.
- **Main sources:** Starter Story's live sitemap and homepage, ten relevant public data pages, direct founder interviews, current official product sites, and the recalculated [`analysis.csv`](analysis.csv) worksheet.

## One-page answer

### The platform is large; the public evidence is still selected

The live sitemap contained **19,123 URLs**, including **3,264 story URLs** and **40 data-category pages**. The homepage described the database as **2,997+ revenue-generating projects**. The first set is a URL inventory and the second is a platform claim; neither is a denominator for attempted startups.

### The expanded public excerpt is much larger than the original case set

Ten question-relevant data pages exposed **169 public row occurrences**. Deduplication by domain or record URL left **133 projects**; **120** had a parseable displayed monthly-revenue value.

Among those 120 revenue-known records:

- the 25th percentile was **$11K/month**;
- the median was **$38.5K/month**;
- the 75th percentile was **$123.25K/month**;
- **94 / 120 (78.3%)** displayed at least $10K/month;
- **66 / 120 (55.0%)** displayed at least $30K/month;
- **36 / 120 (30.0%)** displayed at least $100K/month.

These are distributions inside a logged-out, winner-only public excerpt. They describe what is displayed, not what a new project should expect to earn.

### Category labels are discovery tags, not clean business-model bins

Cross-category duplication accounted for **36 / 169 row occurrences (21.3%)**. **24 / 133 unique projects (18.0%)** appeared in more than one selected category. Formula Bot appeared under five labels; the “solo developer” excerpt also included a physical beverage-container company.

The category system is therefore useful for finding cases, but unsafe for adding counts, estimating market share, or treating a category median as a pure business-model median.

### Revenue is much more visible than profit

The eight audited online-software cases have a **$23K reported monthly-revenue median**. Five provide some profit evidence, but only three disclose a margin. The broad excerpt can describe displayed revenue; it cannot repair the missing profit denominator.

### Fully online delivery exists; “vibe coding” covers only the build layer

The audited cases establish that platform workflow tools, one-job generators, mobile utilities, AI wrappers, APIs, and plugins can be delivered as online software. Standard UI, database, payment, and API work is compatible with AI-assisted development.

The same cases show that code is not the whole business. Distribution, retention, model cost, platform fees, parsing accuracy, security, and support often determine whether reported revenue becomes durable profit. Marketplaces and productized services can be online while still depending on two-sided liquidity or human delivery.

## Data summary: read the denominator first

| Layer | Numerator / denominator | Result | What it supports | What it does not support |
|---|---:|---:|---|---|
| Sitemap inventory | 3,264 story URLs / 19,123 total URLs | 17.1% | The site contains thousands of story pages | A count of profitable or current businesses |
| Ten category cards | 2,652 summed memberships | $20K–$200K displayed medians | The scale and range of selected successful collections | A unique project count; the cards overlap |
| Public category excerpt | 169 rows − 36 duplicates | 133 unique projects | A larger observable cross-section of public records | A random or representative platform sample |
| Revenue coverage | 120 / 133 | 90.2% | Most public excerpt records expose a monthly-revenue field | Audited, current, or net revenue |
| Revenue distribution | 120 revenue-known records | $11K / $38.5K / $123.25K P25 / median / P75 | The displayed winner distribution is wide and right-skewed | Expected income for a new project |
| Cross-category overlap | 24 / 133 unique projects | 18.0% | Labels frequently describe the same business | Mutually exclusive model comparisons |
| Audited case profit coverage | 5 / 8 any evidence; 3 / 8 margins | 62.5%; 37.5% | Profit evidence is sparse even in selected cases | A platform-wide profit rate |

All inputs, formulas, and scope notes are in [`analysis.csv`](analysis.csv).

## 1. Method and evidence boundary

The analysis uses four layers:

1. **Site inventory:** the public sitemap supplies URL counts, including story and data-page families.
2. **Platform aggregates:** the homepage supplies the platform's project claim and ten relevant category-card counts and medians.
3. **Public excerpt:** the default logged-out records on ten selected data pages supply item-level displayed revenue for a broader descriptive sample.
4. **Case audit:** eight online-software interviews and two counterexamples supply cost, margin, churn, labor, and distribution context.

The ten selected public data pages were [Micro SaaS](https://www.starterstory.com/data/micro-saas-ideas), [No-code](https://www.starterstory.com/data/no-code-ideas), [Simple apps](https://www.starterstory.com/data/apps-so-simple), [Solo developers](https://www.starterstory.com/data/solo-developer-ideas), [GPT wrappers](https://www.starterstory.com/data/gpt-wrapper-ideas), [Weekend projects](https://www.starterstory.com/data/weekend-projects), [APIs](https://www.starterstory.com/data/1m-apis), [Plugins](https://www.starterstory.com/data/plugins), [Marketplaces](https://www.starterstory.com/data/marketplaces), and [Productized services](https://www.starterstory.com/data/productized-services).

### Collection boundary

The public excerpt was collected with **11 GET requests**: one homepage and ten category pages. Requests were single-threaded with a four-second interval, an identifying research user agent, no login, no pagination guessing, and no bypass of access controls. No 403, 429, or challenge response occurred.

Starter Story's [robots file](https://www.starterstory.com/robots.txt) allows the public site except `/admin`. Its [terms](https://www.starterstory.com/terms) require a link back when data are used and restrict republication. This report therefore publishes aggregate calculations and direct links only; the row-level extraction remains local and is not part of the public repository.

### Operational definitions

| Term | Definition |
|---|---|
| Displayed revenue | Monthly revenue shown by Starter Story or stated in a founder interview. It is not independently audited. |
| Profit-evidenced | A case explicitly states profit, margin, or costs that allow a profit relationship to be checked. Revenue alone does not qualify. |
| Fully online | Product delivery, acquisition, payment, and support can occur remotely without inventory or on-site fulfillment. |
| AI-assisted build scope | A first version mainly uses standard UI, database, payment, and API work that AI coding tools can accelerate. It is a technical description, not a business score. |

## 2. What the public category data show

The ten homepage cards contain **2,652 category memberships** in total, but the excerpt proves that memberships overlap. Their displayed medians span **$20K to $200K per month**, a tenfold range.

| Public collection | Displayed projects | Displayed median | Public rows | Revenue rows | Excerpt median |
|---|---:|---:|---:|---:|---:|
| Micro SaaS | 670 | $40K | 23 | 18 | $12.17K |
| No-code SaaS and apps | 314 | $30K | 20 | 18 | $36K |
| Simple apps | 241 | $20K | 8 | 7 | $51.3K |
| Solo developers | 237 | $40K | 23 | 21 | $77K |
| GPT wrappers | 148 | $30K | 24 | 19 | $16K |
| Weekend projects | 135 | $30K | 8 | 7 | $15K |
| APIs | 54 | $80K | 7 | 7 | $24.8K |
| Plugins | 19 | $30K | 8 | 8 | $26.5K |
| Marketplaces | 285 | $200K | 24 | 24 | $108.5K |
| Productized services | 549 | $40K | 24 | 24 | $48.5K |

The card median and excerpt median are different measures. The card uses the platform's full curated collection; the excerpt uses only default public rows. Large gaps, such as $80K versus $24.8K for APIs, show why the excerpt should not be mistaken for a category census.

The broad pattern survives the caveat: the displayed marketplace records are larger than the displayed software collections, while APIs and plugins use much smaller denominators. That says more about the shape of Starter Story's successful-case library than about which model is easier or more likely to work.

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

### Recalculations supported by public inputs

| Case | Calculation | Result | Bounded reading |
|---|---|---:|---|
| Data Fetcher | known costs 3,500 / revenue 23,000 | 15.2% known cost share | Broadly consistent with the founder's stated 85% margin; labor and tax remain excluded |
| ChartDetector | profit 11,500 / revenue 43,700 | 26.3% margin | Paid acquisition and platform fees consumed roughly three quarters of revenue |
| Bank Statement Converter | current 12,500 / TTM monthly average 10,518 − 1 | +18.8% | Current MRR exceeded the historical monthly average; this is not a profit measure |

Two counterexamples keep the interpretation bounded. [DealA](https://www.starterstory.com/stories/deala) reported more than $250K invested for roughly $2K monthly profit and negative ROI. [Antropy](https://www.starterstory.com/stories/antropy) reported a record monthly profit above £30K, but with a five-person agency team. Both are online; neither shows that a small codebase produces a low-labor asset.

## 4. Which structures fit fully online, AI-assisted delivery

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

## 5. What the evidence does not establish

| Missing evidence | Why it changes the reading |
|---|---|
| Failed-project denominator | A library of revenue-generating projects cannot estimate the probability that an attempt reaches the displayed scale |
| Random sampling | Default public rows are curated and ordered by the platform; their percentiles are descriptive only |
| Current audited profit | Founder interviews use different dates and definitions; only 3 of 8 audited cases disclose a margin |
| Mutually exclusive categories | 18.0% of unique excerpt projects appear in multiple selected categories, and some labels include visibly different business types |
| Founder labor and support | Revenue rarely includes unpaid founder time, exception handling, maintenance, or customer support |
| Causal effect of AI coding | Cases show coexistence between AI use and shipped products, not the effect of AI on revenue or quality |
| Distribution transferability | An audience, marketplace position, search ranking, affiliate launch, or ad model may be specific to one case |
| Long-term retention | Most interviews provide point-in-time revenue, not comparable cohort or net-retention data |

## 6. Evidence ledger

| Source | Type | Observation used | Confidence and limit |
|---|---|---|---|
| [Starter Story sitemap](https://www.starterstory.com/sitemap) | First-party site inventory | 19,123 URLs, 3,264 story URLs, 40 data pages | High for the cutoff snapshot; URL counts are not business or profit counts |
| [Starter Story homepage](https://www.starterstory.com/) | First-party live display | 2,997+ project claim, category counts, and medians | Medium; platform-defined, overlapping, self-reported winner library |
| [Ten public data pages](https://www.starterstory.com/data/micro-saas-ideas) | First-party public excerpt | 169 row occurrences, 133 unique records, 120 revenue fields | Medium for displayed rows; default-ordered, non-random, selected winners |
| [Starter Story terms](https://www.starterstory.com/terms) and [robots](https://www.starterstory.com/robots.txt) | First-party access boundary | Linkback and republication constraints; public crawl rules | High for the cutoff; terms can change |
| [Eight case interviews](https://www.starterstory.com/stories/how-i-built-it-23k-month-micro-saas) | Founder interviews | Revenue, profit, margin, costs, churn, distribution, and build details | Medium; self-reported, different dates, not audited |
| [Official product sites](https://datafetcher.com/) | First-party product pages | Selected products still had a public offer at the cutoff | High for availability; no independent financial verification |

Additional current product checks: [Profit AI](https://tryprofit.ai/), [Formula Bot](https://www.formulabot.com/), [SiteGPT](https://sitegpt.ai/), [Bank Statement Converter](https://bankstatementconverter.com/), [Supergrow](https://www.supergrow.ai/), and [ChartDetector](https://chartdetectorai.com/).

## Final judgment

The expanded evidence changes the strength, not the direction, of the conclusion. Starter Story is large enough to show that many online business shapes have reported revenue. Its public excerpt contains 133 unique projects and a $38.5K displayed monthly-revenue median among 120 revenue-known records, but that number belongs to a curated winner set.

Profit remains the limiting field. In the eight audited online-software cases, five provide any profit evidence and only three disclose a margin. The best-supported fully online shape in this report is therefore not the category with the largest displayed median; it is the case with the most complete evidence: Data Fetcher, a narrow platform workflow tool with revenue, paid accounts, named costs, and a stated margin. That is an existence result, not a recommendation or success-rate estimate.
