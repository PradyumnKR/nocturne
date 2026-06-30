#!/usr/bin/ env bash
set -Eeuo pipefail 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/terminal.sh"

print_info "This is an info message"
print_error "This is an error message"
print_warning "This is a warning message"
print_success "This is a success message"