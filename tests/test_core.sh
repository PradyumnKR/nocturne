#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"

TEST_DIR="$(mktemp -d)"

cleanup() {
    rm -rf "$TEST_DIR"
}

trap cleanup EXIT

print_info "Testing core library..."

# Terminal library
print_success "Terminal library loaded successfully."

# Validation library
if command_exists git; then
    print_success "Validation library loaded successfully."
else
    print_error "Validation library failed to load."
    exit 1
fi

# Filesystem library
TEST_FILE="$TEST_DIR/test.txt"

echo "Nocturne test file." > "$TEST_FILE"

backup_file "$TEST_FILE"

print_success "Filesystem library loaded successfully."

# Logging library
if declare -f log_message >/dev/null; then
    print_success "Logging library loaded successfully."
else
    print_error "Logging library failed to load."
    exit 1
fi

# Config library
if declare -f install_config >/dev/null; then
    print_success "Config library loaded successfully."
else
    print_error "Config library failed to load."
    exit 1
fi

print_success "All core libraries loaded successfully."