# Research

一个面向决策的行业调研库。每份调查同时提供：

- README.md：事实、推理、引用与研究限制的单一来源；
- index.html：低阅读压力、可交互、适合公开传播的阅读版本。

所有 HTML 共用同一套视觉与交互语言。调整 assets/research.css 顶部的语义变量，即可批量换肤；调整 assets/research.js，可以统一升级阅读模式、目录、进度与可选交互组件。

## 当前调查

| 调查 | 截点 | Markdown | 交互版 |
|---|---|---|---|
| 众筹商品与独立游戏专项调查 | 2026-08-10 | [阅读报告](crowdfunding-and-indie-games-research/README.md) | [打开 HTML](crowdfunding-and-indie-games-research/index.html) |

## 仓库结构

~~~text
Research/
├─ assets/
│  ├─ research.css              # 视觉令牌、组件、响应式与打印
│  └─ research.js               # 阅读模式、目录、进度和可选交互
├─ docs/
│  ├─ research-to-html-workflow.md
│  ├─ visual-system.md
│  └─ codex-git-workflow.md
├─ research-template/
│  ├─ README.md
│  └─ index.html
├─ scripts/
│  └─ Validate-ResearchSite.ps1
├─ <research-slug>/
│  ├─ README.md                 # 研究事实源
│  └─ index.html                # 面向读者的呈现层
├─ index.html                   # 调查目录，可直接作为 GitHub Pages 首页
└─ README.md
~~~

## 新建一份调查

1. 复制 research-template/，并把目录改成稳定的英文 slug。
2. 先完成 README.md，再把内容编排到 index.html。
3. 保留共享资源引用，不复制 CSS 到报告目录。
4. 更新本 README 和根目录 index.html 的调查列表。
5. 运行验证脚本。

~~~powershell
powershell -ExecutionPolicy Bypass -File scripts/Validate-ResearchSite.ps1
~~~

详细规则见：

- [从调研到 HTML 的制作规范](docs/research-to-html-workflow.md)
- [Research Visual System 视觉系统](docs/visual-system.md)
- [可复制的研究页面模板](research-template/README.md)

## 核心原则

- 筹资额、销售额、下载量等公开指标不自动等于利润或商业成功。
- 当前数据必须标注调查截点；实时榜单不得伪装成年度趋势。
- 一手来源优先，平台自报、案例材料与研究者推断必须明确区分。
- HTML 不能引入 Markdown 中没有依据的新事实。
- 交互只用于降低理解成本或帮助决策，不用于装饰。
- 页面必须离线可读、键盘可用、可打印，并覆盖 320–1440px 视口。

## GitHub Pages

仓库根目录已经提供 index.html。将 GitHub Pages 的发布源设置为 main 分支根目录后，即可把它作为调查目录首页。各报告使用相对路径引用共享资产，因此无需构建步骤。
