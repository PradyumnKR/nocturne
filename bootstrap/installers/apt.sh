#!/usr/bin/env bash

install_apt() {

    print_info "Preparing APT environment..."

    if ! command_exists apt-get; then
        print_error "APT package manager is not available."
        return 1
    fi

    print_success "APT package manager detected."

    if update_package_index; then
        print_success "APT environment prepared successfully."
    else
        print_error "Failed to prepare APT environment."
        return 1
    fi
}