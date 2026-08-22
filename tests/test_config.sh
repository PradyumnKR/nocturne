#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/terminal.sh"
source "$PROJECT_ROOT/bootstrap/libs/config.sh"

TEST_DIR="$(mktemp -d)"
SOURCE_FILE="$TEST_DIR/source.conf"
DESTINATION_FILE="$TEST_DIR/config/app.conf"

cleanup() {
    rm -rf "$TEST_DIR"
}

trap cleanup EXIT

printf 'Nocturne test configuration\n' > "$SOURCE_FILE"

print_info "Testing config installer"

install_config \
    "$SOURCE_FILE" \
    "$DESTINATION_FILE"

if [[ ! -f "$DESTINATION_FILE" ]]; then
    print_error "Destination file was not created"
    exit 1
fi

if ! cmp -s "$SOURCE_FILE" "$DESTINATION_FILE"; then
    print_error "Installed config does not match source"
    exit 1
fi

print_success "Config installation works"

printf 'Updated configuration\n' > "$DESTINATION_FILE"

install_config \
    "$SOURCE_FILE" \
    "$DESTINATION_FILE"

if ! compgen -G "$DESTINATION_FILE.bak.*" > /dev/null; then
    print_error "Backup was not created"
    exit 1
fi

print_success "Config backup works"

print_success "All config tests passed"