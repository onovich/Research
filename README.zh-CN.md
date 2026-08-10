# Research

[English](README.md) · **简体中文**

面向独立创作者和小团队的证据型 Go / No-Go 决策研究。Research 使用当下数据形成可行动结论，再发布为美观、低阅读压力的中英文网页版报告。

当前首个专题簇聚焦独立游戏融资、发行与众筹经济性。

[浏览研究目录](https://research.onovich.com/index.zh-CN.html) · [使用 AI 工作流](https://research.onovich.com/tools/research-to-html/index.zh-CN.html)

## 研究报告

- [众筹商品与独立游戏](https://research.onovich.com/crowdfunding-and-indie-games-research/index.zh-CN.html) · [English](https://research.onovich.com/crowdfunding-and-indie-games-research/)
  总报告：解释商品盈利结构、平台适配，以及一款独立游戏是否已适合众筹。
- [哪些独立游戏类型与玩法更适合众筹？](https://research.onovich.com/indie-game-crowdfunding-genres-and-gameplay/index.zh-CN.html) · [English](https://research.onovich.com/indie-game-crowdfunding-genres-and-gameplay/)
  配套深挖：对照当下平台样本、七类受众与玩法模式、失败反例和十分制决策卡。

两份页面共用部分证据，但解决的问题不同：第一份负责整体众筹决策，第二份专门回答游戏类型与玩法是否适配。

## 用 AI 创建报告

用 Codex 或其他兼容 Agent Skills 的助手打开仓库，然后输入：

> 使用 `$research-to-html` 调研**「你的决策问题」**，并生成中英文网页版报告。

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
