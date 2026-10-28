---
name: research-workflow
description: 服务器端 Codex 科研工作流。项目初始化、读取用户从 Mac 手动复制到 related_work/ 的论文资料、Baseline 复现、研究假设讨论、实验记录、标准化评估与 handoff 交接时使用。无需安装或调用 paper-reading。
---

# 科研工作流（Codex 服务器版）

基于 skJack/research-workflow，保留「论文资料 → Baseline 复现 → 提出假设 → 运行实验 → 迭代」的轻量文件工作流。**项目文件是长期记录；不要仅依赖当前会话的对话历史。**

## 两阶段边界（必须遵守）

1. **Mac 本地阅读**：用户在 Mac 上用独立的 `paper-reading` Skill 阅读、理解论文，形成每篇论文的完整资料文件夹。
2. **用户手动复制**：用户自行把完整论文文件夹放进本服务器项目的 `related_work/<论文名称>/`。这里的论文目录是服务器上的真实副本，不是指向项目根目录的索引。
3. **服务器科研**：本 Skill 直接读取 `related_work/` 下已有的 PDF、LaTeX、`code/`、`figures/`、`精读笔记.md` 等，开展 Baseline 复现、假设形成和自己的实验。

**不要调用 `$paper-reading`，不要要求在服务器安装它，不要自动新建根目录论文文件夹，不要自动重新下载或移动用户拷贝的论文。**缺少资料时先说明缺什么；只有用户明确要求才使用 `scripts/fetch-paper.sh` 补抓 arXiv 论文。

## 新项目初始化

项目初建时确认（已知就不用问）：研究项目名及一句话目标、目标期刊/会议与截止时间（可待定）、领域标准术语。然后执行：

```bash
bash <skill>/scripts/init-project.sh <项目目录>
```

`<skill>` 是本 `SKILL.md` 所在路径。脚本只补缺失的文件和目录，不覆盖已有内容。若已有 `AGENTS.md`，先阅读它，必要时参考 `assets/templates/AGENTS-snippet.md` 提出可合并内容，不擅自重写。

## 新会话读取顺序

1. 项目根目录 `AGENTS.md`：目标、术语、硬规矩。
2. `handoff.md`：已完成、当前问题、下一步及踩坑记录。
3. 做论文相关工作时**直接读取** `related_work/<论文名称>/` 中存在的材料，先阅读 `精读笔记.md`，再按需核对 PDF、LaTeX、图和代码。不要假设所有资料一定齐全。
4. 进行 Baseline 复现时先读取 `reproduction/<方法名>/reproduction-plan.md`（若尚未创建，则从模板建立），再查看代码和 `report.md`；做实验时还须读 `experiment/evaluation.md`、`experiment/results.md` 和相关运行记录。

**只加载当前任务相关文件**；不要为了初始化而把整个论文代码仓库全部读入上下文。

## 项目文件职责

| 路径 | 用途 |
|---|---|
| `AGENTS.md` | 项目总纲、长期规则 |
| `handoff.md` | 跨 Codex 会话的进度交接 |
| `brainstorm.md` | 研究问题、假设、反对意见及证伪记录（倒序） |
| `related_work/<论文名称>/` | 用户从 Mac 复制来的整套阅读资料：PDF、源文件、图表、精读笔记、官方代码（如有） |
| `reproduction/<方法名>/reproduction-plan.md` | 运行前的复现计划：目标与证据、代码/数据版本、指标、成功标准、资源与审批 |
| `reproduction/<方法名>/` | Baseline 复现工作副本、环境、配置、日志和 `report.md` |
| `experiment/evaluation.md` | 统一评估数据、指标、分组、失败样例及可视化 |
| `experiment/results.md` | 逐版实验汇总，失败和作废版本也保留 |
| `experiment/<版本名>/run.md` | 每版实验的运行命令、版本、seed、环境、状态、产物 |
| `DataSet/` + `dataset.md` | 数据和处理说明、划分依据 |

## 科研工作节奏

```
读取 related_work/ 论文资料 → 复现关键 Baseline → 提研究假设 → 跑实验 → 循环
```

**优先先复现再提假设**，通过真实运行辨别论文和代码未解释的边界。理论研究、没有官方代码等特殊情形可调整顺序并记录原因。

### Baseline 复现：先计划，再执行

1. 从 `related_work/<论文名称>/` 阅读论文、笔记，交叉核对官方代码的配置、数据、处理流程、评估实现；缺少证据时明确标注，不猜测。
2. **正式执行之前**在 `reproduction/<方法名>/reproduction-plan.md` 建立或完善计划（复制 `assets/templates/reproduction-plan.md`）。列清要复现的论文表/图/setting、代码来源和 commit、数据及 split、指标与论文报告值、预先确定的成功标准、seed/重复次数、环境资源、验证步骤和阻塞项。
3. 向用户展示计划与未决问题；在**用户确认执行范围后**才安装依赖、运行陌生代码或开始训练。计划中的成功标准不得因结果不理想而事后修改；确有变更时记录原因。
4. **原始拷贝保持只读**；不要直接修改/执行 `related_work/<论文名称>/code/` 中的第三方项目代码。经用户确认后，在 `reproduction/<方法名>/` 内准备工作副本、隔离环境及复现配置；先 smoke test、核查中间输入输出，再运行完整实验。
5. 在 `reproduction/<方法名>/report.md` 记录论文报告值、复现结果、代码/数据版本、运行条件、日志路径、失败与差异，并回链复现计划。**运行通过不等于复现指标达到论文目标。**

如果当前任务只是「制定复现计划」，仅创建和核查文档，不擅自执行代码。已存在计划时优先增量更新，不能覆盖已验证的内容。

### 研究假设、实验与数据

1. **效果明显变好，首先排查泄漏。** 数据划分要符合希望泛化的维度（来源、类别、被试、时间等）。
2. **核查中间过程**：输入/输出、shape、label、预处理、划分、指标实现，不能只看最终分数。
3. 每个实验版本用 `v<序号>_<核心改动>` 命名；失败和作废也记录，不覆盖旧结果。
4. 按 `experiment/evaluation.md` 的固定协议测试，完整汇报全部约定指标、分组和固定失败样例；若要变更协议，先说明原因、另记版本。
5. 每次实验在 `experiment/<版本名>/run.md` 填真实 commit、数据版本、seed、运行命令与环境（模板 `assets/templates/run.md`），再向 `experiment/results.md` **追加**结果。未知信息写“未记录”，不能猜。
6. `brainstorm.md` 保留假设提出、反对意见、实验验证与否定过程。只用领域已有术语，不编造文献事实、数值或运行结论。
7. 修改代码、安装依赖、执行未知代码、联网或启动长时间训练前，先说明目标、影响、预计资源与验证方法，经用户确认后操作。

## 会话交接

完成重要阶段、出现阻塞或准备切换会话时更新 `handoff.md`。写清已验证事实及证据路径、已排除的原因、当前任务、具体下一步和踩过的坑。下一个 Codex 会话应可直接按记录继续，不要求依靠之前的聊天记忆。

## 辅助工具

- `scripts/init-project.sh`：初始化目录和 Markdown 模板（幂等，不覆盖）。
- `scripts/fetch-paper.sh`：只有用户**明确要求在服务器下载** arXiv 材料时才使用，**不是正常阅读→复现流程的必备步骤**。
- `assets/templates/`：原版模板的少量 Codex 适配；增加 `reproduction-plan.md`（Baseline 执行前计划）与 `run.md`（实验运行元数据）模板。