#!/usr/bin/env bash

set -Eeuo pipefail

install_environment() {

    print_info "Installing Nocturne environment..."

    install_apt

    
    install_git
    install_python
    install_node
    install_neovim

    
    install_shell

    
    install_starship
    
    
    install_banner

    print_success "Nocturne environment installed successfully."
}