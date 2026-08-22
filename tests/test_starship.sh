#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"
source "$PROJECT_ROOT/bootstrap/installers/starship.sh"

print_info "Testing Starship installer..."

# --------------------------------------------------
# Test 1: Installer function exists
# --------------------------------------------------

if declare -f install_starship >/dev/null; then
    print_success "install_starship function loaded successfully."
else
    print_error "install_starship function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test 2: Starship configuration exists
# --------------------------------------------------

STARSHIP_CONFIG="$PROJECT_ROOT/configs/starship/starship.toml"

if [[ -f "$STARSHIP_CONFIG" ]]; then
    print_success "Starship configuration exists."
else
    print_error "Starship configuration was not found."
    exit 1
fi

# --------------------------------------------------
# Test 3: Starship is installed
# --------------------------------------------------

if command_exists starship; then
    print_success "Starship binary detected."
else
    print_error "Starship binary was not found."
    exit 1
fi

# --------------------------------------------------
# Test 4: Starship configuration syntax
# --------------------------------------------------

if starship print-config >/dev/null 2>&1; then
    print_success "Starship configuration is valid."
else
    print_error "Starship configuration is invalid."
    exit 1
fi

# --------------------------------------------------
# Test 5: Test installation in isolated HOME
# --------------------------------------------------

TEST_HOME="$(mktemp -d)"

cleanup() {
    rm -rf "$TEST_HOME"
}

trap cleanup EXIT

export HOME="$TEST_HOME"

if install_starship; then
    print_success "Starship installer executed successfully."
else
    print_error "Starship installer failed."
    exit 1
fi

# --------------------------------------------------
# Test 6: Configuration was installed
# --------------------------------------------------

INSTALLED_CONFIG="$HOME/.config/starship.toml"

if [[ -f "$INSTALLED_CONFIG" ]]; then
    print_success "Starship configuration was installed."
else
    print_error "Starship configuration was not installed."
    exit 1
fi

# --------------------------------------------------
# Test 7: Installed configuration matches source
# --------------------------------------------------

if cmp -s "$STARSHIP_CONFIG" "$INSTALLED_CONFIG"; then
    print_success "Installed Starship configuration matches source."
else
    print_error "Installed Starship configuration differs from source."
    exit 1
fi

# --------------------------------------------------
# Test 8: Installer is idempotent
# --------------------------------------------------

if install_starship; then
    print_success "Starship installer is idempotent."
else
    print_error "Starship installer failed on second run."
    exit 1
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All Starship installer tests passed."