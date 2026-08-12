# Online projects that make money

**Subtitle:** Eight online-software cases have a $23K reported monthly-revenue median, but only five provide any profit evidence. Revenue scale and solo-build fit are different questions.

**English** · [简体中文](README.zh-CN.md) · [English HTML](../../site/starter-story-vibe-coding-businesses/index.html) · [中文 HTML](../../site/starter-story-vibe-coding-businesses/index.zh-CN.html)

> Research cutoff: 2026-08-12 (China Standard Time)
> Geography: global, English-language online businesses visible on Starter Story
> Question: which currently visible business patterns report meaningful revenue, and which can be delivered fully online with an AI-assisted, “vibe coding” development workflow?
> Outside the analytical subset: inventory-led commerce, local services, regulated products, marketplaces that require two-sided liquidity, and agencies whose revenue primarily depends on human delivery.

## Research context

- **Background:** Starter Story curates businesses that already report revenue, so its category pages are useful for finding monetized patterns but are affected by self-reporting, overlapping categories, and survivor selection.
- **Purpose:** Identify which visible online-business types report revenue or profit evidence, and which observed delivery structures are technically compatible with a fully online, AI-assisted build workflow—without estimating startup success rates.
- **Main sources:** Starter Story's live database and category pages, direct founder interviews, current official product sites, and the report's recalculated `analysis.csv` dataset.

## One-page answer

**What the sample shows**

- Reported monthly revenue ranges from $12.5K to $50K. The median is $23K.
- Five of eight cases provide some profit evidence.
- Only three disclose a margin. The other cases cannot be compared on profit.

**What the figures add**

- Data Fetcher's known hosting and software costs equal 15.2% of MRR, close to the founder's stated 85% margin.
- ChartDetector reported $43.7K of April revenue and about $11.5K of profit—a recalculated margin of 26.3%.
- Higher revenue therefore did not imply a higher margin in these examples.

**What the figures do not prove**

Starter Story's marketplace collection has a median five times the Micro-SaaS median. But it omits failed projects, cold-start cost, and profit coverage. That comparison cannot establish which model is easier or more likely to succeed.

**Narrowest supported inference:** focused workflow tools inside established platforms are technically compatible with AI-assisted development and can generate subscription revenue. Data Fetcher provides the sample's most complete combination of revenue, customer count, costs, and margin. One case establishes existence; it does not supply a success rate or a recommendation.

## Data summary: read the denominator before the conclusion

| Metric | Raw values | Recalculated result | What it supports | What it does not support |
|---|---|---:|---|---|
| Selected cases' reported monthly revenue | 12.5, 15, 19, 23, 23, 30, 43.7, and 50 USD thousands | $23K median; 4× max/min | The revenue scale of these eight cases | Typical revenue for all new products |
| Any profit evidence | 5 / 8 | 62.5% | Most selected cases at least claim profit or disclose it | Consistent, audited, or durable profit definitions |
| Disclosed profit margin | 3 / 8 | 37.5% | Directly comparable margin evidence is sparse | The other five cases are necessarily unprofitable |
| Marketplace / Micro-SaaS page median | $200K / $40K per month | 5.0× | Marketplace winners are larger in the curated library | Better solo fit or higher success odds |
| API / Micro-SaaS collection size | 54 / 670 | 8.1% | The API median comes from a much smaller set | Mutually exclusive or equally stable samples |
| Plugin / Micro-SaaS collection size | 19 / 670 | 2.8% | The plugin median has a small denominator | The population median for plugins |

All inputs and formulas are in [`analysis.csv`](analysis.csv). Collections overlap, interviews come from different dates, and every case passed a success-story filter. The figures compare evidence strength; they do not estimate startup success rates.

## 1. Definitions and method

### What the report means

| Term | Definition |
|---|---|
| Reported revenue | Revenue or MRR stated by the founder or displayed by Starter Story. It is not independently audited. |
| Profit-evidenced | The public case explicitly states profit, margin, or a cost-and-profit figure. Revenue alone does not qualify. |
| Fully online | Product delivery, acquisition, payment, and support can all occur remotely without inventory or on-site work. |
| AI-assisted build scope | A first version made mainly of standard UI, database, payments, and API work that AI coding tools can accelerate. This describes implementation scope, not a business-success score. |

### Evidence design

The report uses three layers:

- Starter Story’s live homepage and category counts as a current snapshot;
- direct case pages for revenue, profit, cost, growth, churn, and founder statements;
- official product sites to verify that the selected products still had a live public offer at the cutoff.

Starter Story calls the database “revenue-generating” while also marketing it as profitable. This report uses the narrower term attached to each piece of evidence. Category counts overlap, update live, and select businesses that already have revenue; they are not a denominator and do not estimate the chance that a new startup succeeds.

## 2. What currently appears to make money

At the cutoff, the [Starter Story homepage](https://www.starterstory.com/) displayed 2,997+ revenue-generating projects and more than $4 billion in combined monthly revenue. It also showed overlapping curated collections.

| Live collection | Visible projects | Displayed median | What the snapshot suggests | What it cannot establish |
|---|---:|---:|---|---|
| Micro SaaS | 670 | $40K/mo | Narrow recurring software is common in the successful-case library. | A typical outcome or probability of reaching $40K. |
| No-code SaaS and apps | 314 | $30K/mo | Code depth is not required for every monetized workflow. | That no-code removes product, distribution, or support work. |
| Simple apps | 241 | $20K/mo | A small feature surface can support a real business. | That “simple” means easy acquisition or operation. |
| Solo developers | 237 | $40K/mo | One-person software businesses are visible at meaningful scale. | Survivorship, time invested, or prior expertise. |
| GPT wrappers | 148 | $30K/mo | AI model access can be packaged into paid workflows. | Defensibility, margin after model costs, or current churn. |
| Weekend projects | 135 | $30K/mo | Some businesses began with a very small initial build. | That the current business still takes a weekend to operate. |
| APIs | 54 | $80K/mo | Infrastructure and automation can have high willingness to pay. | Reliability cost, support load, or the median of all attempted APIs. |
| Plugins | 19 | $30K/mo | Existing platforms can supply context and distribution. | Platform risk or whether the sample is large enough to generalize. |
| Marketplaces | 285 | $200K/mo | Two-sided businesses can reach high revenue. | Their cold-start difficulty, take rate, liquidity, or profit. |
| Productized services | 549 | $40K/mo | Packaging expertise can produce online cash flow. | A code-leveraged or low-labor business. |

The category table is useful for discovering patterns, not for forecasting a new founder’s income. The collections overlap and exclude the failed-project denominator.

## 3. Case evidence: revenue is not profit

| Case | Public figure used | Profit evidence | Fully online | What actually drove the result |
|---|---|---|---|---|
| [Data Fetcher](https://www.starterstory.com/stories/how-i-built-it-23k-month-micro-saas) | $23K MRR; 600 paying customers | Founder stated an 85% margin; hosting about $2.5K/mo and other SaaS tools about $1K/mo | Yes | Airtable marketplace discovery, repeated API-import use cases, integration content, and years of focus |
| [Supergrow](https://www.starterstory.com/stories/how-i-made-65k-in-3-days) | More than $19K/mo after a $65K three-day lifetime-deal launch | Founder stated a 60–70% margin | Yes | A validated LinkedIn-tool category, an existing audience, affiliate launch, and a weekend MVP |
| [ChartDetector](https://www.starterstory.com/stories/i-make-50k-per-month-working-5-hours-a-week) | April revenue $43.7K; around $50K/mo at interview | About $11.5K profit and a 25% margin after roughly $20K ad spend and Apple fees | Yes | Paid TikTok acquisition, hard-paywall onboarding, measurement, and ad creative—not feature count |
| [Formula Bot](https://www.starterstory.com/stories/excelformulabot) | $23K in the reported month | Founder said the site was profitable and gross profit was growing; no margin disclosed | Yes | A narrow Excel job, an early category position, influencer sharing, SEO, and low marketing spend |
| [Bank Statement Converter](https://www.starterstory.com/stories/bankstatementconverter) | $12.5K MRR in the case; $126,218 trailing-12-month revenue | Founder said it became profitable after stopping Google Ads; no margin disclosed | Yes | Search demand, repeated accountant use, bank-specific parsing accuracy, and ongoing support |
| [Profit AI](https://www.starterstory.com/stories/i-turned-this-spreadsheet-into-a-30k-month-micro-saas) | $30K MRR for the app plus just under $40K MRR in services | No public net-profit figure used | Yes | A consulting spreadsheet turned into Shopify software; built with AI tools, but still facing churn |
| [Erly](https://www.starterstory.com/stories/this-insanely-simple-app-makes-50k-month) | Founder reported $50K/mo and 200K+ downloads | No public profit figure used | Yes | A one-sentence alarm outcome, subscription pricing, UGC/influencer distribution, and four years of self-taught coding |
| [SiteGPT](https://www.starterstory.com/stories/sitegpt) | Around $15K MRR in the interview | No public profit figure used; model and vector-database costs were uncertain | Yes | A 2–3 week core MVP plus a 10K-follower launch audience; nearly 50% first-month churn exposed the retention problem |

All amounts are founder-reported or displayed by Starter Story for different interview dates. They are directional case evidence, not audited current financial statements.

### What the public inputs let us recalculate

| Case | Public inputs | Calculation | Result | Bounded reading |
|---|---|---|---:|---|
| Data Fetcher | $23,000 MRR; $3,500 known hosting and tool cost | 3,500 / 23,000 | 15.2% known cost share | Broadly consistent with the stated 85% margin; labor, tax, and undisclosed expenses remain excluded |
| Data Fetcher | $23,000 MRR; stated 85% margin | 23,000 × 85% | about $19,550/month | An implication under the founder's definition, not audited profit |
| Supergrow | at least $19,000 monthly revenue; stated 60–70% margin | 19,000 × 60–70% | about $11,400–$13,300/month | Uses the revenue lower bound and the founder's margin definition |
| ChartDetector | $43,700 April revenue; $11,500 profit | 11,500 / 43,700 | 26.3% | Close to the stated 25%; acquisition and platform costs consumed roughly three quarters of revenue |
| Bank Statement Converter | $126,218 trailing-12-month revenue; $12,500 current MRR | 126,218 / 12; 12,500 / 10,518 − 1 | $10,518 TTM monthly average; current run rate 18.8% higher | Supports a faster current run rate, not a profit-margin estimate |

This table is closer to what the public data can answer than “which category is most profitable.” Known cost shares range from roughly 15% to 74% even among fully online software. The sample and definitions are too inconsistent to calculate a population margin.

### Two counterexamples change the interpretation

- [DealA](https://www.starterstory.com/stories/deala) was fully online and technically buildable, yet the founder reported spending more than $250K for about $2K monthly profit and negative ROI. SEO and deal data—not website code—were the bottleneck.
- [Antropy](https://www.starterstory.com/stories/antropy) reported a record monthly profit above £30K, but the agency used a five-person delivery team. It is an online business, not a software asset that one vibe coder can operate alone.

## 4. Which project hypotheses the data support

Starter Story does not measure “vibe-coding fit,” so the project types cannot be ranked precisely. The table separates what was observed, the narrowest inference the observation supports, and the missing variable that could overturn it.

| Project hypothesis | Observed data | Inference allowed by the data | Still needed before concluding |
|---|---|---|---|
| Platform workflow tool | Data Fetcher reported $23K monthly revenue, 600 paid accounts, and an 85% margin; identifiable costs equal about 15.2% of revenue | A fully online tool inside an established platform can produce subscription revenue and high reported profit | Marketplace conversion, customer concentration, and API or native-feature risk |
| One-job generator | Formula Bot reported $23K monthly revenue but no margin | A clear input→output job can be monetized; the data do not establish high profit | Repeat usage, inference cost, organic conversion, and paid-acquisition payback |
| Outcome-driven mobile utility | ChartDetector disclosed profit equal to about 26.3% of monthly revenue; Erly reported $50K monthly revenue without profit | Mobile utilities can reach meaningful revenue, while distribution cost can materially change the net result | Channel retention, post-store-fee gross margin, payback period, and refund rate |
| AI support wrapper | SiteGPT reported $15K MRR, roughly 50% first-month churn, and no profit figure | An AI product can monetize quickly; these data do not establish durable revenue | Cohort churn, model and support cost, and 12-month net revenue retention |
| Two-sided marketplace | The median among Starter Story's successful marketplace cases is $200K/month, five times the micro-SaaS median | The included successful marketplaces are larger; the data do not show that marketplaces are easier to build | Failed-project denominator, transaction rate, two-sided CAC, disputes, and governance cost |
| SEO content or affiliate site | DealA reported more than $250K invested, roughly $2K monthly profit, and negative overall ROI | A site can launch and earn revenue while search-distribution economics remain unattractive | Proprietary data, ranking stability, maintenance cost, and payback period |
| Productized service | Antropy reported a record monthly profit above £30K with a five-person delivery team | A fully online service can be profitable; the evidence does not make it a solo software asset | Labor per revenue unit, utilization, customer concentration, and automatable share |

**Inference:** Within this case set, the most complete evidence belongs to a narrow workflow tool inside an established platform: it includes revenue, paid accounts, margin, and cost inputs. That makes it the best-documented observed profile in the sample, but one case cannot estimate the probability of success.

### AI-assisted development changes one measured variable

Profit AI shows that a non-programmer can use AI tools to ship chargeable software; the same case reports a retention problem. The narrower conclusion supported by the evidence is that AI lowers the barrier to a first build, not that it improves acquisition, retention, or unit economics.

## 5. What the evidence does not establish

| Missing evidence | Why it changes the interpretation |
|---|---|
| Failed-project denominator | The database selects businesses that already generate revenue, so it cannot estimate the probability that a new project reaches the displayed scale |
| Current, audited profitability | Founder interviews use different dates and profit definitions; only 3 of 8 selected cases disclose a margin |
| Founder labor and support burden | A technically small product can still require high-touch sales, support, data repair, or content work |
| Causal effect of AI-assisted coding | Profit AI shows that AI tools can help ship software, but it does not isolate their effect on revenue, retention, or profit |
| Distribution transferability | Existing audiences, marketplaces, paid acquisition, SEO positions, and affiliate launches differ across cases and may not transfer to a new entrant |
| Long-term retention | Several interviews provide point-in-time MRR; only limited churn or cohort evidence is public |

## 6. Evidence ledger

| Source | Type | Observation used | Confidence and limit |
|---|---|---|---|
| [Starter Story homepage](https://www.starterstory.com/) | Live platform snapshot | Project count, combined-revenue claim, category counts, medians, and current examples | Medium for the displayed cutoff state; curated, overlapping, self-reported, survivor-biased |
| [Data Fetcher case](https://www.starterstory.com/stories/how-i-built-it-23k-month-micro-saas) | Founder interview | $23K MRR, 85% margin, costs, platform distribution, tech stack | Medium; founder-reported and not audited |
| [Supergrow case](https://www.starterstory.com/stories/how-i-made-65k-in-3-days) | Founder interview | launch revenue, current revenue, 60–70% margin, costs, market validation | Medium; founder-reported and point-in-time |
| [ChartDetector case](https://www.starterstory.com/stories/i-make-50k-per-month-working-5-hours-a-week) | Founder interview | April revenue, ad spend, Apple fees, profit, acquisition model | Medium; founder-reported and paid-acquisition dependent |
| [Formula Bot case](https://www.starterstory.com/stories/excelformulabot) | Founder interview | MRR, profitability statement, marketing spend, SEO and influencer channels | Medium; no disclosed margin |
| [Bank Statement Converter case](https://www.starterstory.com/stories/bankstatementconverter) | Founder interview | revenue, profitability statement, zero ad spend, conversion and support burden | Medium; no disclosed margin; sensitive-document risk |
| [Profit AI case](https://www.starterstory.com/stories/i-turned-this-spreadsheet-into-a-30k-month-micro-saas) | Founder interview | AI-assisted build process, MRR, service revenue, paying-user and churn signals | Medium; no disclosed profit and mixed software/service economics |
| [Erly case](https://www.starterstory.com/stories/this-insanely-simple-app-makes-50k-month) | Founder interview | reported monthly revenue, downloads, product and distribution stack | Medium; no disclosed profit |
| [SiteGPT case](https://www.starterstory.com/stories/sitegpt) | Founder interview | 2–3 week MVP, $15K MRR, launch audience, cost uncertainty, churn | Medium; older case and no profit figure |
| [DealA case](https://www.starterstory.com/stories/deala) | Founder interview | negative ROI after $250K+ spend and roughly $2K monthly profit | Medium; selected counterexample |
| [Official product sites](https://datafetcher.com/) | First-party product pages | Current public availability of selected products at the cutoff | High for product availability; no independent financial verification |

Additional current product checks: [Profit AI](https://tryprofit.ai/), [Formula Bot](https://www.formulabot.com/), [SiteGPT](https://sitegpt.ai/), [Bank Statement Converter](https://bankstatementconverter.com/), [Supergrow](https://www.supergrow.ai/), and [ChartDetector](https://chartdetectorai.com/).

## Final judgment

Three numbers set the strength of the conclusion: the selected cases have a $23K reported monthly-revenue median; 5 / 8 contain any profit evidence; only 3 / 8 disclose a margin. Starter Story therefore establishes that these patterns exist. It does not estimate new-project success rates or let category medians rank startup difficulty.

Data Fetcher is the most complete platform-workflow case in the sample: $23K monthly revenue, 600 paid accounts, an 85% reported margin, and known costs equal to about 15.2% of revenue. It therefore provides the best-documented observed profile for a fully online, AI-compatible software business in this selected set—not a recommendation, a representative outcome, or a success estimate.

> Research limit: all business figures are public founder statements or Starter Story displays at different dates. The report cannot verify net income, taxes, founder labor, current churn, or the probability that a new entrant will reproduce any case.
