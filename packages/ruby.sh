#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

# Function to install rbenv
install_package() {
  if is_termux; then
    echo "Ruby will be installed inside the proot-distro for better lib support!"
    return
  fi

  if command_exists rbenv; then
    latest_ruby_version=$(rbenv install -l | grep -v - | tail -1)
    echo "Installing Ruby $latest_ruby_version..."
    rbenv install $latest_ruby_version
    rbenv global $latest_ruby_version
  else
    echo "rbenv is required for ruby installation."
  fi
}

install_package

