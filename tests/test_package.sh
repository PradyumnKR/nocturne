#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"

print_info "Testing package library..."

if declare -f update_package_index >/dev/null; then
    print_success "update_package_index function loaded successfully."
else
    print_error "update_package_index function was not loaded."
    exit 1
fi

if declare -f install_package >/dev/null; then
    print_success "install_package function loaded successfully."
else
    print_error "install_package function was not loaded."
    exit 1
fi

if command_exists git; then
    print_success "Package detection works."
else
    print_error "Package detection failed."
    exit 1
fi


print_info "Testing package binary resolution..."

if [[ "$(resolve_package_binary git)" == "git" ]]; then
    print_success "Default binary resolution works."
else
    print_error "Default binary resolution failed."
    exit 1
fi

if [[ "$(resolve_package_binary ripgrep rg)" == "rg" ]]; then
    print_success "Custom binary resolution works."
else
    print_error "Custom binary resolution failed."
    exit 1
fi

if [[ "$(resolve_package_binary ripgrep)" == "ripgrep" ]]; then
    print_success "Fallback binary resolution works."
else
    print_error "Fallback binary resolution failed."
    exit 1
fi

print_info "Testing package argument handling..."

if install_package git; then
    print_success "Default binary resolution works."
else
    print_error "Default binary resolution failed."
    exit 1
fi

# if install_package ripgrep rg; then
#     print_success "Custom binary resolution works."
# else
#     print_error "Custom binary resolution failed."
#     exit 1
# fi

print_success "Package library tests passed."