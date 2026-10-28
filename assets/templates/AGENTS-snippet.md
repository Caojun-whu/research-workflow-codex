## research-workflow（Codex 服务器端）
- 首先读取本项目的 AGENTS.md 和 handoff.md，再按需查看当前任务。
- Mac 的 paper-reading 与服务器 research-workflow 独立。论文材料由用户手动复制到 related_work/<论文名>/；不得擅自覆盖、重命名或修改。
- Baseline 复现放 reproduction/<方法名>/，先依据 assets/templates/reproduction-plan.md 填计划并经用户确认，再安装依赖、执行代码或训练。
- 原论文与官方代码只作为阅读依据，复现修改与输出在 reproduction/ 中进行。
- 创新实验放 experiment/，先按 evaluation.md 测评，各版本都保留 run.md 和结果日志。
- 最终更新 handoff.md，写明已核验事实、待解决事项、下一步和踩坑。
