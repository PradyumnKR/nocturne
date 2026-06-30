#!/usr/bin/env bash
set -Eeuo pipefail

print_info(){
    echo "[INFO] $1"

    if declare -f log_message >/dev/null; then
        log_message "INFO" "$1"
    fi
}

print_error(){
    echo "[ERROR] $1"

    if declare -f log_message >/dev/null; then
        log_message "ERROR" "$1"
    fi
}

print_warning(){
    echo "[WARNING] $1"

    if declare -f log_message >/dev/null; then
        log_message "WARNING" "$1"
    fi
}

print_success(){
    echo "[SUCCESS] $1"

    if declare -f log_message >/dev/null; then
        log_message "SUCCESS" "$1"
    fi
}