#!/usr/bin/env bash

install_neovim() {

    print_info "Installing Neovim..."

    if ! install_package neovim nvim; then
        print_error "Failed to install Neovim."
        return 1
    fi

    print_success "Neovim environment installed successfully."
}