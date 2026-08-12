# Starter Story online business study

**Subtitle:** What 349 public projects reveal about higher-revenue online businesses and the forms small teams can build with AI.

**English** · [简体中文](README.zh-CN.md) · [English HTML](../../site/starter-story-vibe-coding-businesses/index.html) · [中文 HTML](../../site/starter-story-vibe-coding-businesses/index.zh-CN.html)

## Research context

- **Background:** Starter Story primarily presents businesses that already report revenue. It can show differences among visible success cases, but it does not represent all startup attempts.
- **Purpose:** Compare reported revenue across the 349 projects, determine what the public evidence can establish about profit, and identify which business forms suit online delivery and AI-assisted development.
- **Main sources:** Starter Story's public projects and category statistics, named founder interviews, and current product sites.

> Research cutoff: 2026-08-13 (Asia/Shanghai)
> Scope: global English-language online businesses publicly presented by Starter Story

## Executive summary

- **At least 86 of 349 projects (24.6%) explicitly report $100K or more per month, and at least 151 (43.3%) report $30K or more.** These shares cover all 349 projects; projects without a comparable amount remain unknown, so the results are conservative lower bounds.
- **Projects publishing an amount have a $30K monthly-revenue median, with the middle half at $9K–$113.5K.** Starter Story centers on businesses already generating revenue; this distribution is not a startup success rate.
- **Among the 2,997 projects displayed by the platform, micro-SaaS, productized services, and digital products are the three broadest product-form labels: 670 projects (22.4%), 549 (18.3%), and 455 (15.2%).** A project may carry several labels, so these are overlapping prevalence rates and do not add to 100%.
- **The public evidence cannot say how many of the 349 projects are profitable or what their average profit is.** The database lacks consistent costs, net profit, tax, and founder-labor data. Named cases can explain profit mechanisms, not replace population statistics.
- **Fully online delivery does not imply a light operating model.** APIs, micro-SaaS, plugins, mobile utilities, and one-job tools can be built by small teams using AI, but acquisition, retention, security, reliability, platform fees, and support still drive business outcomes.

## 1. Revenue distribution across 349 projects

| Revenue threshold | Projects explicitly reaching it | Share of all 349 projects |
|---|---:|---:|
| At least $10K/month | 217 | 62.2% |
| At least $30K/month | 151 | 43.3% |
| At least $100K/month | 86 | 24.6% |
| At least $1M/month | 13 | 3.7% |

“At least” matters: projects without a comparable amount remain unknown and are still included among all 349 projects. This prevents more complete disclosure from being mistaken for more common revenue.

Among published amounts, the 25th percentile is **$9K/month**, the median is **$30K**, and the 75th percentile is **$113.5K**. The middle half spans more than twelvefold, so neither a single average nor a headline case represents the group well.

The categories also overlap: **128 of 349 projects (36.7%)** belong to more than one. Categories can compare revenue scale and operating structure, but their project counts cannot be added together or treated as market share.

## 2. Which online business forms report more revenue

Starter Story currently displays 2,997 revenue-generating projects across 39 filterable collections. The table selects ten labels that directly describe a product form; theme, founder identity, and build-method labels are left out.

| Product-form label | Projects in category | Share of 2,997 projects | Reported monthly-revenue median | Plain-language meaning |
|---|---:|---:|---:|---|
| Micro-SaaS | 670 | 22.4% | $40K | Subscription software for a narrow need |
| Productized services | 549 | 18.3% | $40K | Services sold with a fixed scope, price, and process |
| Digital products | 455 | 15.2% | $20K | Reusable files or content such as templates, ebooks, and courses |
| Marketplaces | 286 | 9.5% | $200K | Platforms matching buyers and sellers and charging for access or transactions |
| Niche blogs | 254 | 8.5% | $10K | Focused content businesses monetized through ads, membership, or affiliates |
| Simple apps | 241 | 8.0% | $20K | Small software products that solve a few repeated tasks |
| GPT apps | 149 | 5.0% | $30K | Product-specific workflows and interfaces built on language models |
| Consumer iOS apps | 79 | 2.6% | $40K | Paid or subscription apps distributed through the App Store |
| APIs | 54 | 1.8% | $80K | Capabilities sold as interfaces that other software calls |
| Plugins | 19 | 0.6% | $30K | Extensions that run inside host platforms such as Airtable or Shopify |

Each percentage is the category count divided by 2,997 and shows how widely that label appears in the platform database. One project can be micro-SaaS, a GPT app, and a plugin at the same time, so the values cannot be added and should not be drawn as a pie. Revenue medians compare reported scale; they do not show which type is easier to make successful or more profitable.

## 3. Revenue is not profit

Starter Story's project database does not provide comparable cost and net-profit data for the 349 projects. A profitable-project count, average profit, and population margin therefore cannot be calculated. The named cases below illustrate margin ranges and cost structures only.

| Case | Reported monthly revenue | Profit result | Main costs and qualification |
|---|---:|---:|---|
| [Data Fetcher](https://www.starterstory.com/stories/how-i-built-it-23k-month-micro-saas) | $23K | 85% stated margin, implying about $19.55K/month | About $2.5K hosting and $1K software; tax and founder labor excluded |
| [Supergrow](https://www.starterstory.com/stories/how-i-made-65k-in-3-days) | Later above $19K | 60–70% stated margin, implying at least $11.4K–$13.3K/month | Affiliate share, software, and operations; profit uses the revenue floor |
| [ChartDetector](https://www.starterstory.com/stories/i-make-50k-per-month-working-5-hours-a-week) | $43.7K in April | About $11.5K profit; 26.3% margin from the reported figures | TikTok acquisition, Apple fees, and ad creative |

Across these three illustrative cases, reported margins or margins calculated from the reported figures range from about 26% to 85%. They do not describe the other 346 projects, but they show why “software revenue” alone does not establish profit quality: acquisition, platform fees, and ongoing operations determine how much revenue remains.

Two counterexamples further separate “fully online” from “low-labor, high-return.” [DealA](https://www.starterstory.com/stories/deala) reported more than $250K invested for roughly $2K monthly profit and negative ROI. [Antropy](https://www.starterstory.com/stories/antropy) reported strong profit, but with a five-person agency team.

## 4. Eight representative online-delivery forms supported by public cases

These are **representative patterns** supported by named cases and platform statistics. They are not an exhaustive classification of the 349 projects, and they are not mutually exclusive. Their purpose is to show what the products actually do and why their operating burdens differ.

| Representative form | What the product actually does | Build layer AI can accelerate | Commercial problem that remains |
|---|---|---|---|
| Platform workflow extension | Data Fetcher imports external API or web data into Airtable, replacing manual transfer | UI, database, payments, external APIs | Platform dependence, store conversion, integration support |
| Focused task tool | Formula Bot turns a described need into an Excel formula or explanation: one input, one clearly bounded output | Narrow input-output flow, rules, or inference | Repeat use, inference cost, search-traffic durability |
| Mobile utility | ChartDetector identifies charts and Erly makes users do push-ups to silence an alarm: each repeats one small task on a phone | Mobile UI, subscriptions, analytics, store integration | Paid acquisition, store fees, cohort retention |
| AI customer-support tool | SiteGPT reads a company's website and answers visitor questions in a chat interface | Data ingestion, chat UI, model and vector APIs | Model cost, answer quality, churn, support |
| API or plugin | ScreenshotOne sells website screenshots through an API; Data Fetcher sells data import as an Airtable extension | Endpoint and host-platform integration | Reliability, security review, platform changes |
| Marketplace | MentorCruise matches mentors and learners and handles listings, trust, and transactions | Standard web and transaction components | Two-sided liquidity, trust, disputes, operations |
| Productized service | Antropy sells delivery with a relatively fixed scope and process rather than quoting every engagement from scratch | Intake, scheduling, and delivery standardization | Labor per dollar, utilization, customer concentration |
| Sensitive-document automation | Bank Statement Converter extracts bank-statement data and turns it into structured output | Upload, extraction, conversion, billing | Security, document variance, exception handling, compliance |

The supported conclusion is narrow: AI can lower the first-build cost of a known workflow. The evidence does not show that AI improves demand, distribution, retention, reliability, or profit.

## 5. Seven important unknowns remain about profit, success rates, and operating effort

| Question | Conclusion |
|---|---|
| How many of the 349 projects are truly profitable? | Unknown; consistent costs, net profit, tax, and founder labor are missing |
| What is the average net profit or margin? | Not calculable; the small number of interviews use different dates and definitions |
| What is the chance that a new project reaches these revenues? | Not calculable; the collection centers on revenue-generating projects and does not include every failed attempt |
| Which business form is easiest to make successful? | Unknown; categories overlap and operating, capital, and labor requirements differ sharply |
| How much founder labor is really involved? | Usually undisclosed; support, exception handling, maintenance, and sales can materially change a “solo” workload |
| How much revenue or profit did AI create? | Not isolated; the cases only show that AI participated in development |
| Will current revenue persist? | Insufficient evidence; only a few cases disclose churn and cohort retention |

## 6. Main sources

- [Starter Story](https://www.starterstory.com/): public project database, category project counts, and revenue medians.
- Founder interviews: Data Fetcher, Supergrow, ChartDetector, Formula Bot, Bank Statement Converter, Profit AI, Erly, SiteGPT, MentorCruise, DealA, and Antropy.
- Current product sites: [Data Fetcher](https://datafetcher.com/), [Profit AI](https://tryprofit.ai/), [Formula Bot](https://www.formulabot.com/), [SiteGPT](https://sitegpt.ai/), [Bank Statement Converter](https://bankstatementconverter.com/), [Supergrow](https://www.supergrow.ai/), [ChartDetector](https://chartdetectorai.com/), and [ScreenshotOne](https://screenshotone.com/docs/getting-started/).

Revenue figures are platform displays or founder statements. They are unaudited and are not net profit.

## Conclusion

These 349 public projects show that fully online businesses can report high revenue, but the spread is wide. Projects publishing an amount have a $30K monthly median, with the middle half from $9K to $113.5K; at least 86 projects explicitly report $100K or more per month.

Profit is the central missing measure. The public database cannot say how many of the 349 projects are profitable or provide an average net profit. The three named cases with explicit profit figures report margins from about 26% to 85%, largely shaped by acquisition, platform fees, and operating structure. AI can accelerate a first build, but it cannot replace evidence for demand, distribution, retention, reliability, and profit.
