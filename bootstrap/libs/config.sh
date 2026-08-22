#!/usr/bin/env bash

install_config() {
    local source="$1"
    local destination="$2"

    if [[ -z "$source" || -z "$destination" ]]; then
        print_error "install_config requires source and destination"
        return 1
    fi

    if [[ ! -f "$source" ]]; then
        print_error "Config source does not exist: $source"
        return 1
    fi

    local destination_dir
    destination_dir="$(dirname "$destination")"

    mkdir -p "$destination_dir"

    if [[ -f "$destination" ]]; then
        local backup="${destination}.bak.$(date +%Y%m%d_%H%M%S)"

        cp "$destination" "$backup"

        print_info "Backed up existing config:"
        print_info "  $backup"
    fi

    cp "$source" "$destination"

    print_success "Installed config:"
    print_success "  $source"
    print_success "→ $destination"
}