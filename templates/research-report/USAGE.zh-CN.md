# 模板使用说明

[English](USAGE.md) · **简体中文**

选择稳定的公开英文 slug。把 Markdown 模板复制到 `reports/<report-slug>/`，把 HTML 模板复制到 `site/<report-slug>/`。

## 使用顺序

1. 先完成并审校 `reports/<report-slug>/` 中的两份 Markdown 调研稿；
2. 同步改写 `site/<report-slug>/` 中的 `index.html` 与 `index.zh-CN.html`；
3. 保持两种语言的结论、数字、限制、来源和交互阈值一致；
4. 替换全部 `example.invalid` URL，补齐正式分享图与 JSON-LD，把 `noindex,nofollow` 改为通过审核的 index/follow 指令，并更新绝对 canonical、互指 hreflang、对应语言链接、目录和章节 id；
5. 保持对 ../assets/i18n.js、../assets/research.css 和 ../assets/research.js 的引用；
6. 只有报告独有的复杂交互才新增 report.js；
7. 把准确的读者文件加入 `public-site.json`，再更新根目录的中英文 README、中英文调查目录与 `site/sitemap.xml`；
8. 运行验证脚本。

## 不要做

- 不要把 `site/assets/research.css` 复制到报告目录；
- 不要修改公共类名来完成单页换肤；
- 不要在 HTML 中加入 README.md 没有依据的新事实；
- 不要隐藏会改变结论的限制条件。

共享 CSS 已包含计算器、筛选器、评分卡、流程、时间线、表格与折叠内容。只有当它们能帮助理解或决策时才使用。
