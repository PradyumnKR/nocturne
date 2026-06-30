#!/usr/bin/env bash
set -Eeuo pipefail

LOG_FILE="/tmp/nocturne.log"

log_message() {
    local level="$1"
    local message="$2"

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" >> "$LOG_FILE"
}