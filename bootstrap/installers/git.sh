#!/usr/bin/env bash

install_git() {

    print_info "Installing Git..."

    if ! install_package git git; then
        print_error "Failed to install Git."
        return 1
    fi

    local config_source="$PROJECT_ROOT/configs/git/gitconfig"
    local config_destination="$HOME/.gitconfig"

    if ! install_config "$config_source" "$config_destination"; then
        print_error "Failed to install Git configuration."
        return 1
    fi

    print_success "Git environment installed successfully."
}