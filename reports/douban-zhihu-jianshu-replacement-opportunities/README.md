# Old web, new wedges

**Subtitle:** What Douban, Zhihu, and Jianshu still do well—and where an independent developer can build without cloning them.

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

**Do not build “the new Douban,” “the new Zhihu,” or “the new Jianshu.”** Their defensibility is not the visible feature set. It is the accumulated corpus, object database, reputation graph, search ranking, community norms, moderation history, and habitual distribution.

The opportunity is to **unbundle one valuable function for one high-density community**:

1. a vertical object database plus expert reputation and workflow;
2. private or small-group community operations software;
3. creator-owned publishing, membership, and migration tools;
4. a user-consented personal library and curation layer;
5. quality, reputation, and moderation tooling sold to existing communities.

The strongest first bet is a **vertical “objects + credible people + recurring work” product**. It can start with a curated database and private contributor cohort, charge for workflow or membership, and use incumbent platforms for distribution instead of trying to migrate their whole audience.

## The premise needs correction

These products may feel old-fashioned, but “small websites” is misleading.

- Zhihu reported 13.5 million average monthly subscribers, 80.3 million cumulative creators, and 953.9 million cumulative pieces of content across more than 1,000 verticals at the end of 2025. Those are company filings, not an independent traffic audit.
- Douban’s value is less about feed innovation and more about a structured cultural-object graph: books, films, music, podcasts, ratings, reviews, collections, tags, groups, and local activities.
- Jianshu still offers low-friction long-form and serialized publishing, Markdown and rich text, interest spaces, subscriptions, and virtual currency. Current audited audience and revenue figures were not found.

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

## Why nobody replaced them one-for-one

### 1. The moat is accumulated state, not code

A competent solo developer can reproduce profiles, posts, comments, follows, search, and recommendations. They cannot instantly reproduce twenty years of objects, ratings, links, trusted identities, search behavior, moderator decisions, and community vocabulary.

### 2. Every public community starts empty

Writers need readers; readers need good writers; knowledgeable contributors need worthwhile questions; object pages need structured data before anyone can review them. Cold start is a coordinated supply-and-demand problem, not an interface problem.

### 3. Functions fragmented instead of migrating together

Users can publish, chat, review, watch video, and join groups across WeChat, Bilibili, short-video platforms, newsletters, and private communities. Creators often multi-home and cross-post. That reduces the need for one successor, while making a new horizontal destination harder to establish.

### 4. Community economics punish generality

Advertising needs scale. Subscriptions need unique recurring value. Creator incentives consume cash. Open discussion creates support, moderation, trust-and-safety, and dispute costs. Zhihu’s audited expenses show that even a very large community is operationally heavy.

### 5. Governance is part of the product

Public user-generated-content services may need identity verification, account governance, content review, complaint handling, comment management, monitoring, and emergency response. AI-generated content adds filing or labeling duties in some cases. Exact obligations depend on the product, but they cannot be deferred until after growth.

### 6. “Old” can be a retention advantage

A quiet archive, stable object URL, familiar reputation signal, and slow-moving norm can be more valuable than constant novelty. Incumbents can remain useful without winning every new attention format.

## Opportunity map

| Wedge | Buyer | Why it can work | Revenue | Solo fit |
| --- | --- | --- | --- | --- |
| Vertical object + expert network | professionals, collectors, serious hobbyists | the corpus can be bounded and seeded; reputation attaches to real work | workflow SaaS, data access, membership | **Strong** |
| Private community operations | clubs, associations, cohorts, creator communities | no public-feed cold start; clear admin pain | per-group subscription | **Strong** |
| Creator-owned publishing stack | writers, educators, analysts | ownership, export, email, payments, and archive are concrete jobs | SaaS + payment fee | **Strong** |
| Personal library / curation layer | power users and researchers | starts single-player; sharing comes later | subscription | **Medium** |
| Moderation / reputation tools | existing communities and platforms | sells infrastructure instead of building the audience | B2B SaaS / API | **Medium–strong** |
| Generic public UGC clone | nobody specific | empty feed, high governance cost, no migration trigger | ads later | **Avoid** |

### Best wedge: a vertical object-and-work graph

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
- The opportunity rankings are inferences from product mechanics, platform economics, community research, and small-team constraints—not startup success probabilities.
- Regulatory requirements vary by service design, audience, content, and deployment. Obtain qualified advice before launching a public UGC or AI-content service.

## Sources

### Platforms and economics

1. [Douban user agreement](https://www.douban.com/about/agreement)
2. [Douban legal statement](https://www.douban.com/about/legal)
3. [Douban current homepage](https://www.douban.com/)
4. [Zhihu 2025 Form 20-F](https://www.sec.gov/Archives/edgar/data/1835724/000110465926044557/zh-20251231x20f.htm)
5. [Zhihu fourth-quarter and fiscal-year 2025 results](https://www.sec.gov/Archives/edgar/data/1835724/000110465926034208/tm269796d1_ex99-1.htm)
6. [Jianshu on the China App Store](https://apps.apple.com/cn/app/%E7%AE%80%E4%B9%A6-%E5%88%9B%E4%BD%9C%E4%BD%A0%E7%9A%84%E5%88%9B%E4%BD%9C/id888237539)

### Market context

7. [CNNIC 56th Statistical Report on China’s Internet Development](https://cnnic.cn/NMediaFile/2025/0730/MAIN1753846666507QEK67ZS9DH.pdf)
8. [CNNIC 57th report release](https://www3.cnnic.cn/n4/2026/0304/c88-11549.html)
9. [Tencent second-quarter 2025 results](https://static.www.tencent.com/uploads/2025/09/16/ec455a8989ba1c03aa2bafe97de0618d.pdf)
10. [Bilibili fourth-quarter and fiscal-year 2025 results](https://www.sec.gov/Archives/edgar/data/1723690/000119312526094863/d119863dex991.htm)

### Governance and community mechanics

11. [China content-ecosystem governance provisions](https://www.cac.gov.cn/2019-12/20/c_1578375159509309.htm)
12. [China internet user-account information provisions](https://www.cac.gov.cn/2022-06/26/c_1657868775042841.htm)
13. [China internet comment-service provisions](https://www.cac.gov.cn/2022-11/16/c_1670253725725039.htm)
14. [CEPR review of online-community governance](https://cepr.org/publications/dp20463)
15. [American Economic Association paper on platform multi-homing](https://www.aeaweb.org/articles?id=10.1257%2Fmic.20210324)
16. [Research paper on two-sided-platform cold start](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5417515)
