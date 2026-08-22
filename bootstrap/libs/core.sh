#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOTSTRAP_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(dirname "$BOOTSTRAP_DIR")"

source "$SCRIPT_DIR/terminal.sh"
source "$SCRIPT_DIR/validation.sh"
source "$SCRIPT_DIR/filesystem.sh"
source "$SCRIPT_DIR/logging.sh"
source "$SCRIPT_DIR/config.sh"