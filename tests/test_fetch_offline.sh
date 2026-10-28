#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bash -n "$ROOT/scripts/fetch-paper.sh"
echo "fetch-paper shell syntax OK; no network download attempted"
