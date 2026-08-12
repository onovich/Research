# Traditional content platforms

**Subtitle:** Can independent developers replace Douban, Zhihu, or Jianshu? Operating data, content stock, and app-store signals test the claim.

- **Research cutoff:** 2026-08-12, Asia/Shanghai
- **Audience:** independent developers and small teams
- **Geography:** mainland China and the Chinese-language internet
- **Decision question:** Can an independent developer replace Douban, Zhihu, or Jianshu today, and is there a viable entrepreneurial opportunity around their weaknesses?

## Scope and evidence rules

- “Replace” means moving enough content supply, relationship and reputation graphs, discovery traffic, and repeated use to make the incumbent unnecessary. A feature clone does not count.
- “Opportunity” means a small-team wedge with a plausible customer, distribution path, and revenue model—not merely a nicer interface.
- Current platform functions come from official product pages, platform agreements, audited filings, and current app-store listings.
- Platform operating figures are labeled as audited, company-reported, or unknown. No current audited scale was found for Jianshu.
- Legal and regulatory notes are product-design constraints, not legal advice. Applicability depends on product scope and deployment.

## Executive conclusion

The available data **do not show that a solo developer can replace any of the three platforms one-for-one**, and they are insufficient to compare true activity across all three. They support three narrower findings:

1. **The state to be moved is large.** Zhihu reports 953.9 million cumulative content items and 80.3 million cumulative creators. A similar interface does not migrate that stock.
2. **Operating expenses exceeded gross profit.** Zhihu's 2025 operating expenses equaled 78.4% of revenue and 130.8% of gross profit. This establishes the scale of expense, not how much came from community governance.
3. **Observable consumer footprints differ sharply.** The China App Store shows roughly 1.59 million, 1.74 million, and 87,000 cumulative ratings for Douban, Zhihu, and Jianshu. Ratings are not MAU, but Jianshu's visible rating count is only about 1/18 to 1/20 of the other two.

The testable startup question is therefore not “can we rebuild the platform?” It is whether one job—object curation, private-community operations, creator-owned publishing, or moderation tooling—can be sold to a named customer group. The current evidence does not identify a proven winner.

## Let the data speak first

| Metric | Public input | Recalculated result | What it shows | What it does not show |
|---|---:|---:|---|---|
| Zhihu total revenue | RMB 3.5989B in 2024; RMB 2.7490B in 2025 | **-23.6%** | The business contracted | It does not identify product, competition, or macro causes |
| Paid-membership revenue | RMB 1.7620B → 1.5389B | **-12.7%**; **56.0%** of 2025 revenue | Membership remains the largest revenue line, but declined | It does not reveal satisfaction or renewal rate |
| Marketing-services revenue | RMB 1.2471B → 843.9M | **-32.3%** | Advertising and marketing contracted faster | It does not by itself prove the model has failed |
| Operating expenses | RMB 2.1550B; gross profit RMB 1.6477B | Operating expense / gross profit **130.8%** | Operating load exceeded gross profit | The filing does not allocate all expense to moderation or community work |
| GAAP result | Net loss RMB 195.2M | Net margin **-7.1%** | Zhihu remained GAAP-loss-making in 2025 | Adjusted non-GAAP net income was RMB 37.9M; the measures are not interchangeable |
| App Store cumulative ratings | Douban 1.59M; Zhihu 1.74M; Jianshu 87K | Douban / Jianshu **18.3×**; Zhihu / Jianshu **20.0×** | A current, observable relative-footprint signal | Ratings are cumulative, not MAU, revenue, or retention |
| Audited operating-data coverage | Current public audited disclosure for Zhihu only | **1 / 3** platforms | Zhihu supports financial recalculation | Douban and Jianshu cannot be ranked on the same basis |

All inputs, formulas, and scope notes are in [`analysis.csv`](analysis.csv).

## What value remains

### Douban: cultural memory and personal identity

Douban combines an object catalog with ratings, reviews, lists, tags, “read / watched / listened” history, and groups. This creates three durable utilities:

- **Reference:** a long-tail lookup and comparison layer around cultural objects.
- **Identity:** a lightweight public record of taste and consumption.
- **Coordination:** groups and topics connect people around niche interests.

Its agreement and legal statement also make the constraint explicit: the object metadata, ratings, reviews, counts, marks, topics, and group data are protected platform content, and unauthorized crawling, extraction, derivative sites, and model training are prohibited. A replacement cannot safely begin by copying the database.

### Zhihu: searchable expertise and question routing

Zhihu’s durable asset is not the answer editor. It is a large, indexed question-and-answer corpus linked to creator identity, topic expertise, reputation, recommendation, and search. Its 2025 filing describes question routing, TopicRank, search and recommendation, creator operations, and paid membership.

The economics also show why a broad community is not a lightweight solo business. Zhihu reported RMB 2.749 billion of 2025 revenue, RMB 195.2 million GAAP net loss, RMB 1.252 billion sales and marketing expense, and RMB 525 million research and development expense. It reported its first full-year adjusted non-GAAP profit, but paid-membership revenue and average monthly subscribers declined year over year.

### Jianshu: accessible long-form publishing

Jianshu’s current iOS listing emphasizes long-form and serialized writing, personalized recommendations, Markdown and rich-text editing, interest spaces, subscription tiers, virtual currency, and member benefits. Its remaining value is a simple on-ramp from “I want to write” to a public archive with some discovery and monetization.

The weak evidence boundary matters: app-store availability and product features are observable, but current active users, creator earnings, retention, and platform profitability are unknown.

## Why no clear one-for-one replacement has appeared

Public data do not directly measure the reason, so the following are evidence-backed mechanisms, not proven causal explanations.

### 953.9 million content items turn migration into a data problem

Zhihu's reported content, creator, and 1,000-plus vertical counts show that the replacement target is more than a publishing interface. Douban also combines object catalogs, ratings, collections, and groups. **Inference:** a new product needs a lawful seed corpus and must coordinate contributors, readers, and object data. Public sources do not disclose the cost of migrating that state.

### Operating expenses above gross profit show that public communities are not light operations

Zhihu's 2025 sales and marketing expense equaled 45.6% of revenue, R&D 19.1%, and total operating expense 78.4%. These lines include many activities and cannot all be labeled governance cost. **Inference:** an open-content product must measure acquisition, moderation, support, and engineering cost—not only build time.

### Observable use has not moved to one successor

Current sources show that people can publish and interact across multiple services; platform multi-homing research likewise explains why users need not select only one. App-store ratings show that the three incumbents retain substantial but uneven cumulative footprints. **Inference:** functional unbundling and coexistence are more plausible than one wholesale migration. This report has no market-share dataset to prove that transition is complete.

### The questions the evidence still cannot answer

- Current MAU, revenue, retention, and operating cost for Douban and Jianshu;
- willingness to migrate or demand for export across all three user bases;
- which unbundled tool users would pay for, and at what price;
- actual moderation, support, and compliance cost for a new public community in mainland China.

## Opportunity hypotheses: add denominators before ranking

The platform data cannot support “strong / medium / weak” startup rankings. A more defensible map states the first falsifiable metric for each hypothesis.

| Hypothesis to test | Observed basis | Decisive unknown | First quantitative test |
| --- | --- | --- | --- |
| Vertical object + expert network | Incumbents show that objects, evaluations, and identity can form durable stock | No willingness-to-pay or return data for a specific niche | 100 objects, 10 contributors; at least 5 users complete a comparison task twice in four weeks |
| Private-community operations | Avoids a public-feed cold start and has a named administrator role | Admin pain and willingness to replace existing group tools are unknown | Interview 12 admins; at least 3 pay or commit budget for the same feature |
| Creator-owned publishing | Jianshu's current publishing and membership features show the job still exists | Willingness to pay separately for ownership, export, and distribution is unknown | 10 writers import real work; at least 3 publish in two consecutive weeks and agree to pay |
| Personal library / curation | Douban demonstrates long-lived recording, collecting, and object organization | Import permission, single-player utility, and payment demand are unknown | Without social features, at least 8 of 20 users return in week two |
| Moderation / reputation tooling | Zhihu's expense structure and regulations show recurring platform operations | Filings do not isolate moderation spend, and buyer budget is unknown | Measure weekly moderation minutes with 5 communities and secure 1 paid pilot |
| Generic public UGC clone | No direct evidence of users moving wholesale | Supply, demand, governance, and revenue denominators are all unknown | Prove one repeated job that works without a public feed before building one |

### One reasonable first test: a vertical object-and-work graph

Choose a niche where people repeatedly evaluate named objects and produce valuable structured work: specialist software, components, venues, grants, competitions, courses, research methods, or production vendors.

Start with:

- 200–1,000 manually verified objects;
- 30–50 credible contributors;
- one recurring workflow such as compare, shortlist, review, submit, procure, or report;
- private or invite-only discussion;
- export and ownership from day one.

Charge for the workflow, trusted data, team collaboration, or membership. The public discussion layer should be earned after the single-player and small-group utility works.

## What vibe coding changes—and what it does not

AI-assisted development can compress:

- CRUD, authentication, profiles, search interfaces, payments, notifications, and moderation queues;
- import/export, admin tools, data normalization, and analytics prototypes;
- fast experiments for one vertical and one cohort.

It does not create:

- a licensed or consented data corpus;
- credible contributors and community norms;
- distribution, repeated use, or willingness to pay;
- production security, privacy, moderation judgment, and legal compliance;
- a reason for users to abandon years of history elsewhere.

## Six-week validation plan

### Week 1: choose the object and recurring job

Interview 12 people in one niche. Collect the exact objects they compare and the files, links, or spreadsheets they use. Stop if there is no repeated decision or coordination job.

### Week 2: seed the corpus manually

Create 100 verified object records and a transparent data policy. Do not scrape protected platform data. Test whether five users return without a social feed.

### Week 3: recruit credible supply

Invite 10 domain contributors and ask each for one structured review, checklist, or comparison. Learn what attribution, ownership, and moderation rules they require.

### Week 4: sell the workflow

Offer a paid private workspace, export, alert, shortlist, or report. Continue only if at least three users or one organization pays or commits budget.

### Week 5: build the smallest product

One object model, one workflow, one permission model, one export path, and one audit log. Keep public posting closed.

### Week 6: measure return behavior

Track second-week return, successful jobs, useful contributions, moderation minutes, and support cost. Open sharing only if it improves acquisition without degrading quality.

## What not to build

- a public general-purpose feed with no pre-existing community;
- a Douban data mirror or unauthorized imported review corpus;
- an ad-funded community that needs millions of page views before revenue;
- an AI-generated content farm that makes quality and governance worse;
- open discussion in a sensitive domain before moderation and escalation are designed;
- a “creator platform” that offers publishing but no ownership, distribution, or paid outcome.

## Evidence boundary and unknowns

- Douban does not publish current audited audience or financial figures in the reviewed sources.
- Jianshu’s current scale, retention, creator earnings, and profitability remain unknown.
- Zhihu’s operating and content figures are company filings; they do not measure content quality or user satisfaction.
- CNNIC and large-platform figures establish the size and fragmentation of Chinese internet usage, not the market share of these three products.
- The opportunity table is a set of hypotheses, not startup success probabilities or a ranking derived from comparable samples.
- Regulatory requirements vary by service design, audience, content, and deployment. Obtain qualified advice before launching a public UGC or AI-content service.

## Sources

### Platforms and economics

1. [Douban user agreement](https://www.douban.com/about/agreement)
2. [Douban legal statement](https://www.douban.com/about/legal)
3. [Douban current homepage](https://www.douban.com/)
4. [Zhihu 2025 Form 20-F](https://www.sec.gov/Archives/edgar/data/1835724/000110465926044557/zh-20251231x20f.htm)
5. [Zhihu fourth-quarter and fiscal-year 2025 results](https://www.sec.gov/Archives/edgar/data/1835724/000110465926034208/tm269796d1_ex99-1.htm)
6. [Douban on the China App Store](https://apps.apple.com/cn/app/%E8%B1%86%E7%93%A3/id907002334)
7. [Zhihu on the China App Store](https://apps.apple.com/cn/app/%E7%9F%A5%E4%B9%8E/id432274380)
8. [Jianshu on the China App Store](https://apps.apple.com/cn/app/%E7%AE%80%E4%B9%A6-%E5%88%9B%E4%BD%9C%E4%BD%A0%E7%9A%84%E5%88%9B%E4%BD%9C/id888237539)

### Market context

9. [CNNIC 56th Statistical Report on China’s Internet Development](https://cnnic.cn/NMediaFile/2025/0730/MAIN1753846666507QEK67ZS9DH.pdf)
10. [CNNIC 57th report release](https://www3.cnnic.cn/n4/2026/0304/c88-11549.html)
11. [Tencent second-quarter 2025 results](https://static.www.tencent.com/uploads/2025/09/16/ec455a8989ba1c03aa2bafe97de0618d.pdf)
12. [Bilibili fourth-quarter and fiscal-year 2025 results](https://www.sec.gov/Archives/edgar/data/1723690/000119312526094863/d119863dex991.htm)

### Governance and community mechanics

13. [China content-ecosystem governance provisions](https://www.cac.gov.cn/2019-12/20/c_1578375159509309.htm)
14. [China internet user-account information provisions](https://www.cac.gov.cn/2022-06/26/c_1657868775042841.htm)
15. [China internet comment-service provisions](https://www.cac.gov.cn/2022-11/16/c_1670253725725039.htm)
16. [CEPR review of online-community governance](https://cepr.org/publications/dp20463)
17. [American Economic Association paper on platform multi-homing](https://www.aeaweb.org/articles?id=10.1257%2Fmic.20210324)
18. [Research paper on two-sided-platform cold start](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5417515)
