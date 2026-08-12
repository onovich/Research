# 仓库架构

[English](repository-architecture.md)

## 分层

```text
site/                       公开网站源码；目录与线上 URL 一致
reports/<public-slug>/      可复核的 Markdown 调研稿
templates/research-report/  可复用的中英文报告模板
.agents/skills/             AI 调研与发布工作流
scripts/                    验证、构建、浏览器检查与分享图工具
docs/                       维护说明
_site/                      自动生成的 Pages 产物；不要手工编辑
```

`public-site.json` 是公开边界：从 `site/` 中按白名单复制到 `_site/`。调研稿、文档、Skill、模板和脚本不会进入网站产物。

## 页面职责

| 公开地址 | 职责 | 主要搜索意图 |
|---|---|---|
| `/crowdfunding-and-indie-games-research/` | 总报告 | 众筹经济性、商品/平台模式与独立游戏渠道证据 |
| `/indie-game-crowdfunding-genres-and-gameplay/` | 配套深挖 | 当前游戏平台快照、类型与玩法、已发售案例、失败模式、平台差异与已观察适配信号 |
| `/tools/research-to-html/` | 主 Skill 产品页 | 把有证据的调研问题转成双语 HTML 报告 |

两份报告不是测试产生的重复页。它们复用同一证据底座，但详细内容实行唯一归属：总报告负责经济性与高层渠道证据，配套报告负责游戏类型、案例、风险、平台差异、证据筛选器与已观察信号表。保留两页并双向互链，但不要把这些详细章节复制回总报告，也不要为近义关键词继续复制页面。

Skill 网页已有明确结论：只保留一个面向 `research-to-html` 主承诺的公开产品页。`research-to-github-pages` 作为可选发布步骤，放在主产品页和 README 中即可。除非真实搜索或支持数据表明存在主页面无法回答的独立任务，否则不再建立第二个近似 Skill 页面。

## 新增报告

1. 中英文 Markdown 调研稿放入 `reports/<public-slug>/`。
2. 中英文公开页面放入 `site/<public-slug>/`。
3. 复用 `site/assets/`，不要在报告目录复制视觉系统。
4. `public-site.json` 只加入读者页面和分享图。
5. 更新目录页、站点地图、双向链接与中英文验证配对。
6. 发布前运行验证、构建和浏览器烟测。

不要再向仓库根目录添加公开 HTML 文件。
