#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"
source "$PROJECT_ROOT/bootstrap/installers/banner.sh"

print_info "Testing banner installer..."

# --------------------------------------------------
# Test 1: Installer function exists
# --------------------------------------------------

if declare -f install_banner >/dev/null; then
    print_success "install_banner function loaded successfully."
else
    print_error "install_banner function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test 2: Banner source exists
# --------------------------------------------------

BANNER_SOURCE="$PROJECT_ROOT/configs/banner/motd"

if [[ -f "$BANNER_SOURCE" ]]; then
    print_success "Banner configuration exists."
else
    print_error "Banner configuration was not found."
    exit 1
fi

# --------------------------------------------------
# Test 3: Banner is not empty
# --------------------------------------------------

if [[ -s "$BANNER_SOURCE" ]]; then
    print_success "Banner configuration contains content."
else
    print_error "Banner configuration is empty."
    exit 1
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All banner tests passed."