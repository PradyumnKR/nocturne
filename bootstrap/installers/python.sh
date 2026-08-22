#!/usr/bin/env bash

install_python() {

    print_info "Installing Python..."

    if install_package python3 python3; then
        print_success "Python environment installed successfully."
    else
        print_error "Failed to install Python."
        return 1
    fi
}