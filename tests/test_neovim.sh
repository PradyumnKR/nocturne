#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"
source "$PROJECT_ROOT/bootstrap/installers/neovim.sh"

print_info "Testing Neovim installer..."

# --------------------------------------------------
# Test 1: Installer function exists
# --------------------------------------------------

if declare -f install_neovim >/dev/null; then
    print_success "install_neovim function loaded successfully."
else
    print_error "install_neovim function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test 2: Run installer
# --------------------------------------------------

print_info "Installing Neovim for testing..."

if install_neovim; then
    print_success "Neovim installer executed successfully."
else
    print_error "Neovim installer failed."
    exit 1
fi

# --------------------------------------------------
# Test 3: Neovim is available
# --------------------------------------------------

if command_exists nvim; then
    print_success "Neovim binary detected."
else
    print_error "Neovim binary was not found after installation."
    exit 1
fi

# --------------------------------------------------
# Test 4: Neovim executes
# --------------------------------------------------

if nvim --version >/dev/null 2>&1; then
    print_success "Neovim executes successfully."
else
    print_error "Neovim failed to execute."
    exit 1
fi

# --------------------------------------------------
# Test 5: Installer is idempotent
# --------------------------------------------------

print_info "Testing Neovim installer idempotency..."

if install_neovim; then
    print_success "Neovim installer is idempotent."
else
    print_error "Neovim installer failed on second execution."
    exit 1
fi

print_success "All Neovim installer tests passed."