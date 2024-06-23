#!/bin/bash

NVM_VERSION=0.39.7

# Source utilities script
source "$(dirname "$0")/../utilities.sh"

# Function to install NVM
install_package() {
  if is_termux; then
    echo "NVM will be installed inside the proot-distro for better lib support!"
    return
  fi

  if command_exists nvm; then
    echo "NVM is already installed."
  else
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  fi
}


install_package

