#!/usr/bin/env bash

set -Eeuo pipefail

install_starship() {

    print_info "Installing Starship..."

    if command_exists starship; then
        print_info "Starship is already installed."
    else
        print_info "Downloading Starship installer..."

        if ! curl -sS https://starship.rs/install.sh | sh -s -- -y; then
            print_error "Failed to install Starship."
            return 1
        fi

        print_success "Starship installed successfully."
    fi

    local config_source="$PROJECT_ROOT/configs/starship/starship.toml"
    local config_destination="$HOME/.config/starship.toml"

    if ! install_config "$config_source" "$config_destination"; then
        print_error "Failed to install Starship configuration."
        return 1
    fi

    print_success "Starship environment installed successfully."
}