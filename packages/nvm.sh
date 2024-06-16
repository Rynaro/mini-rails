#!/bin/bash

# Source utilities script
source "$(dirname "$0")/../utilities.sh"

# Function to install NVM
install_package() {
  if command_exists nvm; then
    echo "NVM is already installed."
  else
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  fi
}


install_package
