# research-workflow-codex

面向服务器端 Codex 的轻量科研协作 Skill，用于利用已有论文资料开展 Baseline 复现、研究假设探索与实验，并维护可跨会话续接的研究进度。

## 安装

将本仓库放入科研项目的 `.agents/skills/research-workflow/`，确保包含 `SKILL.md` 和 `references/records.md`。不需要运行初始化脚本。

## 使用方式

将论文、精读笔记、参考代码等资料放入 `related_work/<论文名>/`。首次进入尚未初始化的项目时，Codex 会建立以下基础结构：

```text
project/
├── related_work/   # 论文及参考资料
├── dataset/        # 复现及自研实验共用的数据
├── reproduction/   # Baseline 复现代码和报告
├── experiment/     # 自研实验代码和结果
├── AGENTS.md       # 项目目标、环境及约束
└── handoff.md      # 研究进度与下一步
```

已有项目直接读取现有记录并续接，不重复初始化。复现计划、评估协议和实验报告等文件根据任务需要创建。

研究数据统一存放在 `dataset/`；首次使用数据、数据变化或发现问题时检查并整理，核验完成后再清理可安全删除的重复文件。论文、笔记和参考代码等原始资料保持只读。

Baseline 复现先明确目标、完成标准、停止条件和资源范围，再在 `reproduction/<方法名>/` 中开展工作。复现不默认要求达到原论文指标；结束时记录真实结果、差异、可用性及局限。自研实验在 `experiment/` 中开展，保留关键配置、运行证据与结果解释。

## 使用示例

```text
使用 $research-workflow。基于 related_work/Geo2Vec/ 制定复现计划，先不要运行。
```

```text
使用 $research-workflow。按已确认的计划和资源范围执行复现，记录实际结果。
```

```text
使用 $research-workflow。读取当前项目的交接记录，继续下一步工作。
```

## 文件说明

| 文件 | 用途 |
|---|---|
| [SKILL.md](SKILL.md) | 工作约定、数据管理、复现与实验执行边界 |
| [references/records.md](references/records.md) | 按需参考的科研记录示例 |
| [LICENSE](LICENSE) | Apache License 2.0 |

## 许可与致谢

本项目改编自 [skJack/research-workflow](https://github.com/skJack/research-workflow)，遵循 Apache License 2.0。
