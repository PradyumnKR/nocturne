#!/usr/bin/env bash

set -Eeuo pipefail

install_environment() {
    print_info "Installing Nocturne environment..."

    install_shell
    install_starship

    print_success "Nocturne environment installed successfully."
}