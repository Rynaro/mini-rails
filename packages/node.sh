#!/bin/bash

# Source utilities script
source "$(dirname "$0")/../utilities.sh"

# Function to install the latest Node.js version
install_latest_node() {
  if command_exists node; then
    echo "Node already installed!"
  else
    echo "Installing the latest Node.js version..."
    nvm install node
    nvm use node
  end
}

install_package
