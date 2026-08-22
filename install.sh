#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"

source "$PROJECT_ROOT/bootstrap/installers/apt.sh"
source "$PROJECT_ROOT/bootstrap/installers/banner.sh"
source "$PROJECT_ROOT/bootstrap/installers/git.sh"
source "$PROJECT_ROOT/bootstrap/installers/node.sh"
source "$PROJECT_ROOT/bootstrap/installers/python.sh"
source "$PROJECT_ROOT/bootstrap/installers/shell.sh"
source "$PROJECT_ROOT/bootstrap/installers/starship.sh"
source "$PROJECT_ROOT/bootstrap/installers/environment.sh"

print_info "Starting Nocturne installation..."

if install_environment; then
    print_success "Nocturne installation completed successfully."
else
    print_error "Nocturne installation failed."
    exit 1
fi