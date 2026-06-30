#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeuo pipefail

command_exists() {
    command -v "$1" >/dev/null 2>&1
}