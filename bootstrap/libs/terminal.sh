#!/usr/bin/env bash
set -Eeuo pipefail

print_info(){
    echo "[INFO] $1"
}

print_error(){
    echo "[ERROR] $1"
}

print_warning(){
    echo "[WARNING] $1"
}

print_success(){
    echo "[SUCCESS] $1"
}