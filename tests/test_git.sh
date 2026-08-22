#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"
source "$PROJECT_ROOT/bootstrap/installers/git.sh"

print_info "Testing Git installer..."

# --------------------------------------------------
# Test 1: Installer function exists
# --------------------------------------------------

if declare -f install_git >/dev/null; then
    print_success "install_git function loaded successfully."
else
    print_error "install_git function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test 2: Git is available
# --------------------------------------------------

if command_exists git; then
    print_success "Git binary detected."
else
    print_error "Git binary was not found."
    exit 1
fi

# --------------------------------------------------
# Test 3: Installer handles existing Git
# --------------------------------------------------

if install_git; then
    print_success "Git installer executed successfully."
else
    print_error "Git installer failed."
    exit 1
fi

# --------------------------------------------------
# Test 4: Verify Git still works
# --------------------------------------------------

if git --version >/dev/null 2>&1; then
    print_success "Git executable is working."
else
    print_error "Git executable failed."
    exit 1
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All Git installer tests passed."