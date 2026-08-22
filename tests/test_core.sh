#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"

print_info "Testing terminal library..."
print_success "Terminal library loaded successfully."

if command_exists git; then
    print_success "Validation library loaded successfully."
else
    print_error "Validation library failed to load."
fi

echo "Nocturne test file." > test.txt

backup_file test.txt

print_success "Filesystem library loaded successfully."

if declare -f log_message >/dev/null; then
    print_success "Logging library loaded successfully."
else
    print_error "Logging library failed to load."
fi

print_info "Core library test completed successfully."