#!/bin/bash

NODE_LTS=v20.15

# Source utilities script
safe_source "$(dirname "$0")/../utilities.sh"

# Function to install the latest Node.js version
install_latest_node() {
  if is_termux; then
    echo "NodeJS will be installed inside the proot-distro for better lib support!"
    return
  fi

  if command_exists node; then
    echo "Node already installed!"
  else
    echo "Installing the latest Node.js version..."
    nvm install $NODE_LTS
  fi
}

install_package

