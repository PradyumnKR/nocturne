#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/terminal.sh"
source "$PROJECT_ROOT/bootstrap/libs/filesystem.sh"

echo "original file" > sample.txt

backup_file sample.txt