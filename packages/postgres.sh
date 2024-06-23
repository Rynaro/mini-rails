#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

# Function to install NVM
install_package() {
  if command_exists psql && psql --version | grep -q " $POSTGRES_VERSION."; then
    echo "PostgreSQL in any version is already installed."
  else
    if is_termux; then
      safe_source "packages/termux/postgres.sh"
    elif is_linux && is_debian_bookworm; then
      echo "Postgres is installed using Termux Packages to get a properly patched revision for Android Devices!"
      echo "Check this file source to find the experimental source attempt to get this done inside the Proot Distro!"
      # safe_source "packages/debian/postgres.sh"
    fi
  fi
}


install_package

