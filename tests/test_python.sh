#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"
source "$PROJECT_ROOT/bootstrap/installers/python.sh"

print_info "Testing Python installer..."

# --------------------------------------------------
# Test 1: Installer function exists
# --------------------------------------------------

if declare -f install_python >/dev/null; then
    print_success "install_python function loaded successfully."
else
    print_error "install_python function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test 2: Python is available
# --------------------------------------------------

if command_exists python3; then
    print_success "Python binary detected."
else
    print_error "Python binary was not found."
    exit 1
fi

# --------------------------------------------------
# Test 3: Installer handles existing Python
# --------------------------------------------------

if install_python; then
    print_success "Python installer executed successfully."
else
    print_error "Python installer failed."
    exit 1
fi

# --------------------------------------------------
# Test 4: Verify Python works
# --------------------------------------------------

if python3 --version >/dev/null 2>&1; then
    print_success "Python executable is working."
else
    print_error "Python executable failed."
    exit 1
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All Python installer tests passed."