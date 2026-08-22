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

    if [[ -z "${1:-}" ]]; then
        print_error "No package name provided."
        return 1
    fi

    local package="$1"
    local binary

    binary="$(resolve_package_binary "$@")"

    if command_exists "$binary"; then
        print_success "Package '$package' is already installed."
        return 0
    fi

    print_info "Installing package '$package'..."

    if sudo apt-get install -y "$package"; then
        print_success "Package '$package' installed successfully."
    else
        print_error "Failed to install package '$package'."
        return 1
    fi
}

resolve_package_binary() {

    if [[ -z "${1:-}" ]]; then
        print_error "No package name provided."
        return 1
    fi

    local package="$1"
    local binary="${2:-$1}"

    printf '%s\n' "$binary"
}

install_package_group() {

    if [[ -z "${1:-}" ]]; then
        print_error "No package group provided."
        return 1
    fi

    local group_name="$1"
    local package_list_file="$PROJECT_ROOT/packages/${group_name}.txt"

    if [[ ! -f "$package_list_file" ]]; then
        print_error "Package list file for group '$group_name' not found."
        return 1
    fi

    print_info "Installing package group '$group_name'..."

    while IFS= read -r package; do

        if [[ -z "$package" || "$package" =~ ^# ]]; then
            continue
        fi

        if ! install_package "$package"; then
            print_error "Failed to install package '$package' from group '$group_name'."
            return 1
        fi

    done < "$package_list_file"

    print_success "Package group '$group_name' installed successfully."
}