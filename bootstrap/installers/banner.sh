#!/usr/bin/env bash

install_banner() {

    print_info "Installing Nocturne SSH banner..."

    local source="$PROJECT_ROOT/configs/banner/motd"
    local destination="/etc/motd"

    if ! install_config "$source" "$destination"; then
        print_error "Failed to install SSH banner."
        return 1
    fi

    print_success "Nocturne SSH banner installed successfully."
}