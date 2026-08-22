#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"
source "$PROJECT_ROOT/bootstrap/installers/apt.sh"

print_info "Testing APT installer..."

# --------------------------------------------------
# Test 1: Installer function exists
# --------------------------------------------------

if declare -f install_apt >/dev/null; then
    print_success "install_apt function loaded successfully."
else
    print_error "install_apt function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test 2: APT exists
# --------------------------------------------------

if command_exists apt-get; then
    print_success "APT package manager detected."
else
    print_error "APT package manager was not found."
    exit 1
fi

# --------------------------------------------------
# Test 3: Package index update
# --------------------------------------------------

if update_package_index; then
    print_success "APT package index update works."
else
    print_error "APT package index update failed."
    exit 1
fi

# --------------------------------------------------
# Test 4: Installer works
# --------------------------------------------------

if install_apt; then
    print_success "APT installer executed successfully."
else
    print_error "APT installer failed."
    exit 1
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All APT installer tests passed."