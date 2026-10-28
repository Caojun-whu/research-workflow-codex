# 与 skJack/research-workflow 的差异

上游：https://github.com/skJack/research-workflow

本版以原版单 Skill、固定目录和科研循环为基础，仅做服务器 Codex 场景下的小幅优化：

1. **Codex 适配**：Skill 安装在项目的 `.agents/skills/research-workflow/`，Codex 按 `AGENTS.md`、`handoff.md` 读取项目状态。
2. **Mac/服务器分工**：Mac 本地独立使用 `Caojun-whu/paper-reading-skill`；用户自行复制论文文件夹至服务器的 `related_work/<论文名>/`。服务器不用安装/调用 `paper-reading`，不自动下载或重写这些资料。
3. **英文目录名**：将上游 `复现/` 统一替换为 **`reproduction/`**，用于 Baseline 复现代码与 `report.md`。
4. **实验可复现性**：增加 `assets/templates/run.md`，每版记录 Git commit、数据版本、seed、环境、执行命令和产物。
5. **更明确的交接与执行边界**：重要阶段更新 `handoff.md`；正式执行第三方代码或高成本实验前先确认。
6. **脚本**：`init-project.sh` 保留不覆盖的幂等性质；`fetch-paper.sh` 保留为用户明确要求时才使用的备用功能，增加输入校验与安全解包。
7. **测试**：初始化脚本的幂等性、保留外部拷贝论文资料、英文 reproduction 目录和备用下载脚本离线检查。

本版不包含或改动 `Caojun-whu/paper-reading-skill` 的代码。不生成原版未有的文献索引，也不自动对接两个设备。

许可证：保留上游 Apache License 2.0（见 `LICENSE`）；不是上游官方发行版。

## v0.3：Baseline 复现前计划

8. **增加单一模板，不引入新 Skill**：`assets/templates/reproduction-plan.md`；在 `reproduction/<方法名>/reproduction-plan.md` 记录论文与代码来源、数据、目标指标与预设成功标准、seed、环境资源、风险和批准范围。
9. **流程检查点**：Codex 在运行 Baseline 前先提交计划等待用户确认；在复现结束后将实际结果写入 `report.md`。初始化脚本仍不创建未知方法目录、不覆盖已有文件。