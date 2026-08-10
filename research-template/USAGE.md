# 模板使用说明

复制整个 research-template/ 到仓库根目录，并把目录重命名为稳定的英文 slug。

## 使用顺序

1. 先完成新目录中的 README.md；
2. 改写 index.html 中的方括号占位内容；
3. 更新目录、章节 id 与链接；
4. 保持对 ../assets/research.css 和 ../assets/research.js 的引用；
5. 只有报告独有的复杂交互才新增 report.js；
6. 更新根 README.md 与 index.html；
7. 运行验证脚本。

## 不要做

- 不要把 assets/research.css 复制到报告目录；
- 不要修改公共类名来完成单页换肤；
- 不要在 HTML 中加入 README.md 没有依据的新事实；
- 不要隐藏会改变结论的限制条件。

共享 CSS 已包含计算器、筛选器、评分卡、流程、时间线、表格与折叠内容。只有当它们能帮助理解或决策时才使用。
