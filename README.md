# research-workflow-codex

**版本：v0.3（复现前计划）**

基于 [skJack/research-workflow](https://github.com/skJack/research-workflow) 的 **Codex 服务器科研工作流**，保留原版「文献 → Baseline 复现 → 假设 → 实验」和项目文件管理方式，只进行少量适配。

## 实际使用方式（两台设备、两个独立 Skill）

- **Mac 本地**：用已经安装的 [`Caojun-whu/paper-reading-skill`](https://github.com/Caojun-whu/paper-reading-skill) 阅读论文、查看 PDF/LaTeX/图表/官方代码、形成 `精读笔记.md`。论文文件夹继续遵守该 Skill 在 Mac 上的原有规则，无需修改。
- **手动转移**：将 Mac 上生成的 **整个论文文件夹**（含笔记、PDF、源码、图片和 `code/`，如有）复制到服务器科研项目的 `related_work/` 目录中。例如把 Mac 的 `Geo2Vec/` 复制为服务器的 `related_work/Geo2Vec/`。不需要自动同步、索引、调用另一个 Skill 或重新下载。
- **服务器 Codex**：只安装本 `research-workflow` Skill。直接读取 `related_work/<论文名称>/` 中现成的材料，先制定 `reproduction-plan.md` 并确认、再复现 Baseline（成果放在 **`reproduction/`**），之后讨论研究假设、实施自己的实验，记录指标并维护 `handoff.md`。

这两套 Skill **相互独立**。本仓库不包含、不安装、也不调用 `paper-reading`。

## 安装（服务器）

下载 ZIP，解压后将 `research-workflow-codex` 文件夹放到服务器 Codex 项目的 `.agents/skills/`，并命名为 `research-workflow`：

```bash
# 在服务器科研项目根目录执行
mkdir -p .agents/skills
cp -R /path/to/research-workflow-codex .agents/skills/research-workflow
bash .agents/skills/research-workflow/scripts/init-project.sh .
```

如果项目已经有 `AGENTS.md`，初始化脚本不会覆盖。必要时人工参考 `assets/templates/AGENTS-snippet.md` 合并研究规则。之后重新开启 Codex 会话，以便发现 Skill。

### 使用示例

在 Mac 上使用独立的阅读 Skill 形成 `Geo2Vec/`，**自行将其复制到服务器**的 `<项目>/related_work/Geo2Vec/`。在服务器项目根目录开启 Codex：

```text
使用 $research-workflow。先读 AGENTS.md 和 handoff.md，
检查 related_work/Geo2Vec/ 里已经拷贝好的论文材料，
创建 reproduction/Geo2Vec/reproduction-plan.md（使用 Skill 模板），
核对论文目标指标、代码与数据版本、成功标准、资源和阻塞项；
向我展示计划，未经确认不要安装依赖或执行训练。
```

```text
使用 $research-workflow。针对 reproduction/Geo2Vec/ 的复现结果，
梳理关键误差和可能的研究假设，更新 brainstorm.md；
按 experiment/evaluation.md 制定实验方案。
```

```text
使用 $research-workflow。记录 v4_<方法名> 实验，
填写 experiment/v4_<方法名>/run.md，追加 experiment/results.md，
然后更新 handoff.md。
```

## 服务器项目结构

```text
<研究项目>/
├── AGENTS.md                  # Codex 项目规则
├── handoff.md                 # 跨会话进度交接
├── brainstorm.md              # 研究假设、讨论、否定过程
├── dataset.md                 # 数据处理与划分说明
├── related_work/              # 手动从 Mac 复制的完整论文文件夹
│   ├── Geo2Vec/
│   │   ├── paper.pdf
│   │   ├── source/             # 如 arXiv 提供
│   │   ├── paper.tex          # 如有
│   │   ├── paper.txt          # 如有
│   │   ├── outline.md         # 如有
│   │   ├── figures/           # 如有
│   │   ├── code/              # 已核实的官方代码（如有）；默认只读
│   │   ├── meta.json          # 如有
│   │   └── 精读笔记.md
│   └── 其他论文/
├── reproduction/              # Baseline 复现代码、配置、报告
│   └── Geo2Vec/
│       ├── reproduction-plan.md # 执行前的复现计划（从模板复制）
│       └── report.md            # 运行之后的复现报告
├── experiment/
│   ├── evaluation.md          # 统一评估协议
│   ├── results.md             # 实验版本汇总
│   └── <版本名>/
│       ├── run.md             # 运行环境、seed、commit、数据版本
│       └── metrics.json       # 真正完成实验后才生成
├── DataSet/
└── .agents/skills/research-workflow/
```

如果从旧版本升级，项目里已经存在 `复现/`，请**自行确认后**将旧内容迁移到 `reproduction/`；初始化脚本不会删除或移动已有复现成果。

**约定**：不重命名、移动或覆盖 `related_work/<论文>/` 内从 Mac 复制的文件。阅读和复现都可参考这些材料，但自己的复现代码、运行结果应放在 `reproduction/`，不要回写到 `related_work/`。即便一个论文本身没有 `source/`、`code/` 等也可继续研究，缺失项明确说明。

## 保留与优化

- 保留原版一个 `research-workflow` Skill + `AGENTS.md`、`handoff.md`、`brainstorm.md`、实验和数据模板。
- 文件夹 `复现/` 在服务器端统一改名为 **`reproduction/`**。
- 复现前在 `reproduction/<方法名>/reproduction-plan.md` 固定复现目标、论文与代码证据、数据、指标、成功标准及资源，经用户确认再执行；模板位于 `assets/templates/reproduction-plan.md`，初始化项目时不预建未知方法的目录。
- 不使用 `related_work/index.md` 或根目录论文链接；Codex 按需直接查看复制进来的论文目录。
- 每版实验除汇总表外增加 `experiment/<版本名>/run.md`，记录真实的 Git commit、数据/环境版本、随机种子、命令和产物，缺失项如实标记。
- `scripts/fetch-paper.sh` 作为上游功能的**可选备用脚本**保留，仅在用户明确要求服务器抓取某篇 arXiv 论文时才可使用。正常流程**不自动下载论文**。

开始某个方法的复现时，由 Codex 在 `reproduction/<方法名>/` 复制复现计划模板，检查证据、填写待确认事项并呈交用户；**项目初始化不会凭空为未知方法创建目录，也不会自动启动训练**。例如：

```bash
mkdir -p reproduction/Geo2Vec
[ -e reproduction/Geo2Vec/reproduction-plan.md ] || \
  cp .agents/skills/research-workflow/assets/templates/reproduction-plan.md \
    reproduction/Geo2Vec/reproduction-plan.md
```

以上 `cp` 仅适用于目标文件尚不存在的情况。已存在的计划必须增量修订，不能覆盖。

## 测试

在 Skill 根目录执行：

```bash
bash tests/test_init.sh
bash tests/test_fetch_offline.sh
```

测试覆盖目录初始化、非覆盖/幂等性、复现计划模板就绪、已拷贝论文材料保持原样和备用抓取脚本的离线安全测试。**尚未在用户的服务器环境或真实 Codex 会话中完成端到端测试。**

## 版权与致谢

- 上游：[skJack/research-workflow](https://github.com/skJack/research-workflow)（Apache License 2.0，依据其许可改编）
- 独立的 Mac 阅读 Skill：[Caojun-whu/paper-reading-skill](https://github.com/Caojun-whu/paper-reading-skill)（MIT；本项目不集成其代码）
- 详细修改记录见 `CHANGES.md`。本项目不是上游官方版本。
