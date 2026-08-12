# 模板使用说明

[English](USAGE.md) · **简体中文**

选择稳定的公开英文 slug。把 Markdown 模板复制到 `reports/<report-slug>/`，把 HTML 模板复制到 `site/<report-slug>/`。

1. 先完成并审校 `reports/<report-slug>/` 中的两份 Markdown 调研稿。
2. 中英文 Markdown 与 HTML 都应先用简短的“调研说明”交代背景、要回答的具体问题和主要数据来源。
3. 同步改写 `site/<report-slug>/` 中的两个页面；标题保持简洁，中心发现放进副标题字段。
4. 保持两种语言的发现、数字、限制、来源和交互阈值一致。
5. 替换全部 `example.invalid` URL，补齐正式分享图与 JSON-LD，把 `noindex,nofollow` 改为通过审核的 index/follow 指令，并更新绝对 canonical、互指 `hreflang`、对应语言链接、目录和章节 id。
6. 保持对 `../assets/i18n.js`、`../assets/research.css` 和 `../assets/research.js` 的引用。
7. 只有报告确实需要独有交互时才新增 `report.js`。
8. 把准确的读者文件加入 `public-site.json`，再更新根目录中英文 README、目录页和 `site/sitemap.xml`。
9. 运行仓库验证脚本。

不要复制共享 CSS、为单页换皮而修改公共类名、在 HTML 中增加 Markdown 没有依据的新事实、隐藏会改变结论的限制，也不要假定读者要亲自开发或运营项目。

共享系统支持证据筛选、计算器、用于事实顺序的时间线、表格与折叠内容。只有能降低理解成本时才使用。调研报告中不得加入验证计划、路线图、项目简报、行动评分卡或通用下一步。即使用户明确要求建议，也要另建独立的配套产物，不能把它混进报告。
