#!/usr/bin/env bash

update_package_index() {
    print_info "Updating package index..."

    if sudo apt-get update; then
        print_success "Package index updated successfully."
    else
        print_error "Failed to update package index."
        return 1
    fi
}

install_package() {
    local package="$1"

    if [[ -z "$package" ]]; then
        print_error "No package specified."
        return 1
    fi

    if command_exists "$package"; then
        print_info "$package is already installed."
        return 0
    fi

    print_info "Installing $package..."

    if sudo apt-get install -y "$package"; then
        print_success "$package installed successfully."
    else
        print_error "Failed to install $package."
        return 1
    fi
}