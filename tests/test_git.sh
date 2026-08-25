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
# Test 3: Git installer executes
# --------------------------------------------------

if install_git; then
    print_success "Git installer executed successfully."
else
    print_error "Git installer failed."
    exit 1
fi

# --------------------------------------------------
# Test 4: Git configuration exists
# --------------------------------------------------

if [[ -f "$HOME/.gitconfig" ]]; then
    print_success "Git configuration exists."
else
    print_error "Git configuration was not installed."
    exit 1
fi

# --------------------------------------------------
# Test 5: Verify configuration values
# --------------------------------------------------

if [[ "$(git config --global init.defaultBranch)" == "main" ]]; then
    print_success "Default branch configuration is correct."
else
    print_error "Default branch configuration is incorrect."
    exit 1
fi

if [[ "$(git config --global fetch.prune)" == "true" ]]; then
    print_success "Fetch prune configuration is correct."
else
    print_error "Fetch prune configuration is incorrect."
    exit 1
fi

if [[ "$(git config --global push.autoSetupRemote)" == "true" ]]; then
    print_success "Automatic upstream configuration is correct."
else
    print_error "Automatic upstream configuration is incorrect."
    exit 1
fi

if [[ "$(git config --global rerere.enabled)" == "true" ]]; then
    print_success "Git rerere is enabled."
else
    print_error "Git rerere is not enabled."
    exit 1
fi

print_success "All Git installer tests passed."