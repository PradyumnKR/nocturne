#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"

print_info "Testing Nocturne shell configuration..."

SOURCE="$PROJECT_ROOT/configs/shell/zshrc"
TEST_DIR="$(mktemp -d)"
DESTINATION="$TEST_DIR/.zshrc"

cleanup() {
    rm -rf "$TEST_DIR"
}

trap cleanup EXIT

# --------------------------------------------------
# Test 1: Source configuration exists
# --------------------------------------------------

if [[ -f "$SOURCE" ]]; then
    print_success "Zsh configuration exists."
else
    print_error "Zsh configuration does not exist."
    exit 1
fi

# --------------------------------------------------
# Test 2: Install configuration
# --------------------------------------------------

if install_config "$SOURCE" "$DESTINATION"; then
    print_success "Zsh configuration installed successfully."
else
    print_error "Failed to install Zsh configuration."
    exit 1
fi

# --------------------------------------------------
# Test 3: Destination exists
# --------------------------------------------------

if [[ -f "$DESTINATION" ]]; then
    print_success "Installed Zsh configuration exists."
else
    print_error "Installed Zsh configuration was not created."
    exit 1
fi

# --------------------------------------------------
# Test 4: Configuration contents match
# --------------------------------------------------

if cmp -s "$SOURCE" "$DESTINATION"; then
    print_success "Installed configuration matches source."
else
    print_error "Installed configuration differs from source."
    exit 1
fi

# --------------------------------------------------
# Test 5: Backup existing configuration
# --------------------------------------------------

echo "# Existing configuration" > "$DESTINATION"

if install_config "$SOURCE" "$DESTINATION"; then
    print_success "Existing Zsh configuration was replaced successfully."
else
    print_error "Failed to replace existing Zsh configuration."
    exit 1
fi

BACKUP_COUNT="$(find "$TEST_DIR" -maxdepth 1 -name '.zshrc.bak.*' | wc -l)"

if [[ "$BACKUP_COUNT" -eq 1 ]]; then
    print_success "Existing Zsh configuration was backed up."
else
    print_error "Zsh configuration backup was not created."
    exit 1
fi

# --------------------------------------------------
# Test 6: Validate installed configuration syntax
# --------------------------------------------------

if command -v zsh >/dev/null 2>&1; then

    if zsh -n "$DESTINATION" 2>/dev/null; then
        print_success "Zsh configuration syntax is valid."
    else
        print_error "Zsh configuration contains syntax errors."
        exit 1
    fi

else
    print_warning "Zsh is not installed. Skipping syntax validation."
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All shell configuration tests passed."