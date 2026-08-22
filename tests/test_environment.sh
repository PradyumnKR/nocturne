#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"

source "$PROJECT_ROOT/bootstrap/installers/apt.sh"
source "$PROJECT_ROOT/bootstrap/installers/banner.sh"
source "$PROJECT_ROOT/bootstrap/installers/git.sh"
source "$PROJECT_ROOT/bootstrap/installers/node.sh"
source "$PROJECT_ROOT/bootstrap/installers/python.sh"
source "$PROJECT_ROOT/bootstrap/installers/shell.sh"
source "$PROJECT_ROOT/bootstrap/installers/starship.sh"
source "$PROJECT_ROOT/bootstrap/installers/environment.sh"

print_info "Testing Nocturne environment installer..."

# --------------------------------------------------
# Test 1: Environment installer exists
# --------------------------------------------------

if declare -f install_environment >/dev/null; then
    print_success "install_environment function loaded successfully."
else
    print_error "install_environment function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test 2: Required installer functions exist
# --------------------------------------------------

required_installers=(
    install_apt
    install_banner
    install_git
    install_node
    install_python
    install_shell
    install_starship
)

for installer in "${required_installers[@]}"; do
    if declare -f "$installer" >/dev/null; then
        print_success "$installer is available."
    else
        print_error "$installer is not available."
        exit 1
    fi
done

# --------------------------------------------------
# Test 3: Required environment commands exist
# --------------------------------------------------

required_commands=(
    git
    python3
    node
    npm
    zsh
    fzf
    tmux
    starship
)

for command in "${required_commands[@]}"; do
    if command_exists "$command"; then
        print_success "$command is available."
    else
        print_error "$command is not available."
        exit 1
    fi
done

# --------------------------------------------------
# Test 4: Environment installer executes
# --------------------------------------------------

print_info "Testing environment orchestration..."

if install_environment; then
    print_success "Environment installer executed successfully."
else
    print_error "Environment installer failed."
    exit 1
fi

# --------------------------------------------------
# Test 5: Configuration files exist
# --------------------------------------------------

config_files=(
    "$HOME/.zshrc"
    "$HOME/.config/starship.toml"
)

for config in "${config_files[@]}"; do
    if [[ -f "$config" ]]; then
        print_success "Configuration exists: $config"
    else
        print_error "Configuration missing: $config"
        exit 1
    fi
done

# --------------------------------------------------
# Test 6: Zsh configuration syntax
# --------------------------------------------------

if zsh -n "$HOME/.zshrc"; then
    print_success "Zsh configuration syntax is valid."
else
    print_error "Zsh configuration contains syntax errors."
    exit 1
fi

# --------------------------------------------------
# Test 7: Starship configuration
# --------------------------------------------------

if starship print-config >/dev/null 2>&1; then
    print_success "Starship configuration is valid."
else
    print_error "Starship configuration is invalid."
    exit 1
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All Nocturne environment tests passed."