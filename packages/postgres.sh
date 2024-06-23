#!/bin/bash

# Source utilities script
source "$(dirname "$0")/../utilities.sh"

# Function to install NVM
install_package() {
  if command_exists psql && psql --version | grep -q " $POSTGRES_VERSION."; then
    echo "PostgreSQL in any version is already installed."
  else
    if is_termux; then
      safe_source "packages/termux/postgres.sh"
    elif is_linux && is_debian_bookwork; then
      safe_source "packages/debian/postgres.sh"
    fi
  fi
}


install_package

