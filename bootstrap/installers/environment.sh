#!/usr/bin/env bash

set -Eeuo pipefail

install_environment() {

    print_info "Installing Nocturne environment..."

    print_info "Preparing package manager..."
    install_apt

    print_info "Installing development tools..."
    install_git
    install_python
    install_node

    print_info "Installing shell environment..."
    install_shell

    print_info "Installing Starship..."
    install_starship

    print_info "Installing SSH banner..."
    install_banner

    print_success "Nocturne environment installed successfully."
}