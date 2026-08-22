#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"
source "$PROJECT_ROOT/bootstrap/installers/node.sh"

print_info "Testing Node.js installer..."

# --------------------------------------------------
# Test 1: Installer function exists
# --------------------------------------------------

if declare -f install_node >/dev/null; then
    print_success "install_node function loaded successfully."
else
    print_error "install_node function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test 2: Node.js is available
# --------------------------------------------------

if command_exists node; then
    print_success "Node.js binary detected."
else
    print_error "Node.js binary was not found."
    exit 1
fi

# --------------------------------------------------
# Test 3: Installer handles existing Node.js
# --------------------------------------------------

if install_node; then
    print_success "Node.js installer executed successfully."
else
    print_error "Node.js installer failed."
    exit 1
fi

# --------------------------------------------------
# Test 4: Verify Node.js works
# --------------------------------------------------

if node --version >/dev/null 2>&1; then
    print_success "Node.js executable is working."
else
    print_error "Node.js executable failed."
    exit 1
fi

# --------------------------------------------------
# Test 5: Verify npm
# --------------------------------------------------

if command_exists npm; then
    print_success "npm binary detected."
else
    print_error "npm binary was not found."
    exit 1
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All Node.js installer tests passed."