# research-workflow-codex

**v0.4 · 按需科研协作**

用于服务器 Codex 的轻量 Skill：利用已有论文资料推进 Baseline 复现、研究假设和实验，并保存可继续的进度与结果。

## 使用方式

在 Mac 上使用独立的 [paper-reading](https://github.com/Caojun-whu/paper-reading-skill)，将完整论文目录手动复制到服务器项目的 `related_work/<论文名>/`。服务器上的本 Skill 直接使用这些资料。

目录和项目记录由 Agent 根据当前任务建立；技能包不再包含初始化或论文下载脚本。实际研究所需的训练、数据处理和评估程序保存在各自科研项目中。

## 安装

将本仓库放到服务器项目的 `.agents/skills/research-workflow/`，确保其中有 `SKILL.md` 和 `references/records.md`。无需执行初始化命令，也无需预先创建一套项目文档。

使用示例：

```text
使用 $research-workflow。基于 related_work/Geo2Vec/ 制定复现计划，先不要运行。
```

```text
使用 $research-workflow。按已确认的计划和资源范围执行复现，记录实际结果。
```

```text
使用 $research-workflow。读取当前项目的交接记录，继续下一步工作。
```

## 文件

| 文件 | 用途 |
|---|---|
| [SKILL.md](SKILL.md) | 工作约定、执行边界和交接要求 |
| [references/records.md](references/records.md) | 按需参考的计划、运行、评估和交接记录示例 |
| [LICENSE](LICENSE) | Apache License 2.0 |

## 从旧版升级

v0.4 删除技能包中的两个 `.sh` 脚本、固定模板及对应脚本测试；历史变更说明合并到本页。更新时按上表核对技能目录，移除旧版的 `scripts/`、`assets/templates/`、`tests/` 和 `CHANGES.md`；若曾自行修改这些技能文件，先比对并保留所需内容。

这些变更仅针对技能包。已有科研项目中的 `AGENTS.md`、笔记、复现计划、实验程序和运行记录继续复用，按需增量维护，不因升级删除或重建。已有 `AGENTS.md` 若引用旧技能脚本或模板，仅调整相关条目，保留项目特有约定。

## 来源与版本

改编自 [skJack/research-workflow](https://github.com/skJack/research-workflow)，保留上游 Apache License 2.0。本项目为独立适配版本。

- **v0.3**：明确 Mac/服务器分工，并增加复现前计划与实验运行记录。
- **v0.4**：移除内置脚本与成套模板，改为按需建立文件；新增代码和验证按具体问题决定；统一执行范围，保留复现成功标准、真实结果记录和跨会话交接。
