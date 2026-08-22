#!/usr/bin/env bash

install_git() {

    print_info "Installing Git..."

    if install_package git; then
        print_success "Git environment installed successfully."
    else
        print_error "Failed to install Git."
        return 1
    fi
}