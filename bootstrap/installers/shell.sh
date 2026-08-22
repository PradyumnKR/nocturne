#!/usr/bin/env bash

set -Eeuo pipefail

install_shell() {

    print_info "Installing shell environment..."

    # Install shell packages
    install_package_group shell

    # Install Zsh configuration
    install_config \
        "$PROJECT_ROOT/configs/shell/zshrc" \
        "$HOME/.zshrc"

    print_success "Shell environment installed successfully."
}