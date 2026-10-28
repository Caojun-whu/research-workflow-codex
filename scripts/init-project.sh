#!/bin/bash
# 建一个科研项目的骨架。
#
#   ./init-project.sh ~/Code/my-new-paper
#   ./init-project.sh .                     # 在当前目录建
#
# 已存在的文件不会被覆盖——在已有项目里跑也安全，只补缺的。

set -euo pipefail

DEST="${1:?用法: init-project.sh <项目目录>}"
TPL="$(cd "$(dirname "${BASH_SOURCE[0]}")/../assets/templates" && pwd)"

mkdir -p "$DEST"/{related_work,reproduction,experiment,DataSet}
cd "$DEST"

put() { # $1=模板名 $2=目标路径
  if [ -e "$2" ]; then
    echo "  ·  $2  已存在，跳过"
  else
    cp "$TPL/$1" "$2"
    echo "  +  $2"
  fi
}

put AGENTS.md      AGENTS.md
put handoff.md     handoff.md
put brainstorm.md  brainstorm.md
put dataset.md     dataset.md
put results.md     experiment/results.md
put evaluation.md  experiment/evaluation.md

# .gitignore：数据和大文件别进版本库
if [ ! -e .gitignore ]; then
  cat > .gitignore <<'EOF'
DataSet/
related_work/*/paper.pdf
related_work/*/source/
related_work/*/code/
experiment/*/checkpoints/
experiment/*/*.pt
*.orig
.shot-tmp/
__pycache__/
EOF
  echo "  +  .gitignore"
fi

cat <<'EOF'

科研项目骨架已建立（已存在的文件不会覆盖）。

下一步：
1. 填写 AGENTS.md 的项目名、目标及领域术语。
2. 用户在 Mac 上使用独立 paper-reading Skill，手动复制完整论文文件夹到 related_work/<论文名称>/。
3. 复现前先创建 reproduction/<方法名>/reproduction-plan.md：
   mkdir -p reproduction/<方法名>
   cp <skill>/assets/templates/reproduction-plan.md reproduction/<方法名>/reproduction-plan.md
   （仅在目标计划不存在时复制；应由 Codex 填写并请求用户确认）
4. 经用户确认后执行 Baseline 复现，成果保存在 reproduction/<方法名>/。
5. 随后记录 brainstorm.md、experiment/results.md 和 experiment/<版本名>/run.md。
6. 结束前更新 handoff.md。
EOF
