#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/bootstrap/libs/core.sh"

print_info "Testing package group library..."

# --------------------------------------------------
# Test 1: Function exists
# --------------------------------------------------

if declare -f install_package_group >/dev/null; then
    print_success "install_package_group function loaded successfully."
else
    print_error "install_package_group function was not loaded."
    exit 1
fi

# --------------------------------------------------
# Test environment
# --------------------------------------------------

TEST_DIR="$(mktemp -d)"

cleanup() {
    rm -rf "$TEST_DIR"
}

trap cleanup EXIT

mkdir -p "$TEST_DIR/packages"

# Use a temporary project root so the real package
# manifests are never modified.
PROJECT_ROOT="$TEST_DIR"

# --------------------------------------------------
# Test 2: Create a test package manifest
# --------------------------------------------------

cat > "$TEST_DIR/packages/test.txt" <<'EOF'
# Core tools

git
curl

# Shell tools
fzf
EOF

# --------------------------------------------------
# Test 3: Mock install_package
# --------------------------------------------------

INSTALLED_PACKAGES=()

install_package() {
    INSTALLED_PACKAGES+=("$1")
}

# --------------------------------------------------
# Test 4: Install valid package group
# --------------------------------------------------

if install_package_group test; then
    print_success "Valid package group was processed successfully."
else
    print_error "Valid package group failed."
    exit 1
fi

# --------------------------------------------------
# Test 5: Verify comments and empty lines were ignored
# --------------------------------------------------

EXPECTED_PACKAGES=(
    "git"
    "curl"
    "fzf"
)

if [[ "${#INSTALLED_PACKAGES[@]}" -ne "${#EXPECTED_PACKAGES[@]}" ]]; then
    print_error "Unexpected number of packages processed."
    exit 1
fi

for i in "${!EXPECTED_PACKAGES[@]}"; do

    if [[ "${INSTALLED_PACKAGES[$i]}" != "${EXPECTED_PACKAGES[$i]}" ]]; then
        print_error "Unexpected package at position $i."
        print_error "Expected: ${EXPECTED_PACKAGES[$i]}"
        print_error "Received: ${INSTALLED_PACKAGES[$i]}"
        exit 1
    fi

done

print_success "Package manifest parsing works correctly."

# --------------------------------------------------
# Test 6: Missing package group
# --------------------------------------------------

if install_package_group does-not-exist; then
    print_error "Missing package group should have failed."
    exit 1
else
    print_success "Missing package group fails correctly."
fi

# --------------------------------------------------
# Test 7: Missing group argument
# --------------------------------------------------

if install_package_group; then
    print_error "Missing group argument should have failed."
    exit 1
else
    print_success "Missing group argument fails correctly."
fi

# --------------------------------------------------
# Final result
# --------------------------------------------------

print_success "All package group tests passed."