#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$TMP/proj/related_work/Geo2Vec"
echo "local notes" > "$TMP/proj/related_work/Geo2Vec/精读笔记.md"
echo "existing" > "$TMP/proj/AGENTS.md"
bash "$ROOT/scripts/init-project.sh" "$TMP/proj" >/dev/null
test -d "$TMP/proj/reproduction"
test -d "$TMP/proj/related_work"
test -f "$TMP/proj/experiment/results.md"
test -f "$TMP/proj/experiment/evaluation.md"
test -f "$ROOT/assets/templates/reproduction-plan.md"
test "$(cat "$TMP/proj/AGENTS.md")" = "existing"
test "$(cat "$TMP/proj/related_work/Geo2Vec/精读笔记.md")" = "local notes"
bash "$ROOT/scripts/init-project.sh" "$TMP/proj" >/dev/null
test "$(cat "$TMP/proj/AGENTS.md")" = "existing"
echo "init OK"
