#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/logging.sh"
source "$PROJECT_ROOT/bootstrap/libs/terminal.sh"

print_info "Testing logger"
print_success "Everything works"
print_warning "This is a warning"
print_error "This is an error"