#!/usr/bin/env bash

install_node() {

    print_info "Installing Node.js..."

    if install_package nodejs node; then
        print_success "Node.js environment installed successfully."
    else
        print_error "Failed to install Node.js."
        return 1
    fi
}