#!/bin/bash

# Source utilities script
safe_source "$(dirname "$0")/../utilities.sh"

# Function to install Redis
install_package() {
  echo "Installing Redis..."
  sudo apt install -y redis-server
}

install_package

