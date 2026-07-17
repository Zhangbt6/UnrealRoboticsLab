#!/usr/bin/env bash
# Master Build Script for Synthy Third-Party Dependencies (Linux)

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$ROOT_DIR/install"
BUILD_TYPE="Release"

# Ensure directories exist
mkdir -p "$INSTALL_DIR"

echo -e "\e[36mStarting Unified Build Process...\e[0m"

# 1. CoACD
echo -e "\n\e[33m--- Building CoACD ---\e[0m"
cd "$ROOT_DIR/CoACD"
if [ -f "./build.sh" ]; then
    bash ./build.sh "$INSTALL_DIR" "$BUILD_TYPE"
else
    echo "Error: CoACD/build.sh not found!" >&2
    exit 1
fi
cd "$ROOT_DIR"

# 2. MuJoCo
echo -e "\n\e[33m--- Building MuJoCo ---\e[0m"
cd "$ROOT_DIR/MuJoCo"
if [ -f "./build.sh" ]; then
    bash ./build.sh "$INSTALL_DIR" "$BUILD_TYPE"
else
    echo "Error: MuJoCo/build.sh not found!" >&2
    exit 1
fi
cd "$ROOT_DIR"

# 3. libzmq
echo -e "\n\e[33m--- Building libzmq ---\e[0m"
cd "$ROOT_DIR/libzmq"
if [ -f "./build.sh" ]; then
    bash ./build.sh "$INSTALL_DIR" "$BUILD_TYPE"
else
    echo "Error: libzmq/build.sh not found!" >&2
    exit 1
fi
cd "$ROOT_DIR"

echo -e "\n\e[32mAll builds completed! check the 'install' folder.\e[0m"
