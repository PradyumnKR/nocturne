#!/usr/bin/env bash
set -Eeuo pipefail

backup_file() {
    local file="$1"

    if [[ -f "$file" ]]; then
        local backup="${file}.bak.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup"
        print_warning "Backup created: $backup"
    fi
}