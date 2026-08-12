# Research

[English](README.md) · **简体中文**

Research 帮助独立创作者和小团队基于当下证据调查问题。它把资料与数据整理成清晰的发现、比较和解释，再发布为美观、低阅读压力的中英文网页版报告；需要时，也可以进一步支持具体决策。

它可用于探索问题、梳理行业或平台、分析模式与机制，以及开展 Go / No-Go 评估。当前首个专题簇聚焦众筹经济性与独立游戏众筹适配。

[浏览研究目录](https://research.onovich.com/index.zh-CN.html) · [使用 AI 工作流](https://research.onovich.com/tools/research-to-html/index.zh-CN.html)

## 研究报告

- [众筹商品与独立游戏](https://research.onovich.com/crowdfunding-and-indie-games-research/index.zh-CN.html) · [English](https://research.onovich.com/crowdfunding-and-indie-games-research/)
  总报告：解释商品盈利结构、平台差异、独立游戏的渠道经济性，以及为何现有证据不能推出普遍盈利结论。
- [独立游戏众筹适配](https://research.onovich.com/indie-game-crowdfunding-genres-and-gameplay/index.zh-CN.html) · [English](https://research.onovich.com/indie-game-crowdfunding-genres-and-gameplay/)
  游戏专项深挖：对照当下平台样本、七类受众与玩法模式、已发售案例、失败模式、反复出现的适配信号与平台证据差异。
- [Starter Story 线上项目研究](https://research.onovich.com/starter-story-vibe-coding-businesses/index.zh-CN.html) · [English](https://research.onovich.com/starter-story-vibe-coding-businesses/)
  从 349 个公开项目中，看哪些线上生意收入更高，哪些产品更适合小团队借助 AI 完成。
- [传统内容平台](https://research.onovich.com/douban-zhihu-jianshu-replacement-opportunities/index.zh-CN.html) · [English](https://research.onovich.com/douban-zhihu-jianshu-replacement-opportunities/)
  知乎 2025 年收入同比下降 23.6%，经营费用相当于毛利润的 130.8%。报告用数据检验豆瓣、知乎和简书的替代与周边产品假设，不预设答案。

前两份报告组成一个众筹专题簇，详细章节不再互相重复；其余报告是线上商业与平台机会的独立调查。

## 用 AI 创建报告

用 Codex 或其他兼容 Agent Skills 的助手打开仓库，然后输入：

> 使用 `$research-to-html` 调研**「你的问题或主题」**，并生成中英文网页版报告。

报告完成后输入：

> 使用 `$research-to-github-pages` 检查并发布报告。

主要入口是 [`research-to-html`](.agents/skills/research-to-html/SKILL.md)；[`research-to-github-pages`](.agents/skills/research-to-github-pages/SKILL.md) 是可选发布步骤。如果助手没有自动发现仓库 Skill，可直接打开对应的 `SKILL.md`。

## 目录结构

- `site/`：唯一会进入 GitHub Pages 的网页源码
- `reports/`：可复核的 Markdown 调研稿，不公开部署
- `templates/`：报告模板，不公开部署
- `.agents/skills/`：AI 调研与发布工作流
- `scripts/`：隐私、SEO、构建与浏览器检查
- `docs/`：工作流、架构与视觉系统说明

源码与公开产物的边界、各页面职责见[仓库架构说明](docs/repository-architecture.zh-CN.md)。

## 许可证

代码、Skill、脚本和模板使用 [MIT 许可证](LICENSE)。原创报告文字与视觉内容使用 [CC BY 4.0](CONTENT-LICENSE.md)。第三方材料仍遵循其原有权利规则。
