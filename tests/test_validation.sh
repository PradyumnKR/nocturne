#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/validation.sh"
source "$PROJECT_ROOT/bootstrap/libs/terminal.sh"

if command_exists git; then
    print_success "Git detected."
else
    print_error "Git missing."
fi

if command_exists definitely_not_installed; then
    print_success "Unexpected result."
else
    print_warning "Command does not exist."
fi