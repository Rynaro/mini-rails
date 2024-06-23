#!/bin/bash

PLUGIN_NAME='mini-rails'
PLUGIN_VERSION='1.0.0'
PLUGIN_RELATIVE_FOLDER="$(dirname "$0")/$1"

# Source utilities script
source "$PLUGIN_RELATIVE_FOLDER/utilities.sh"

# Function to prepare to install packages
prepare() {
  if is_debian_bookworm || is_termux; then
    update_repositories
  else
    echo "This script is designed for Termux and Debian Bookworm as PRoot Distro."
    exit 1
  fi
}

# Function to install packages
install_packages() {
  echo "Installing Plugin: mini-rails..."
  safe_source "packages/postgres.sh"
  safe_source "packages/rbenv.sh"
  safe_source "packages/ruby.sh"
  safe_source "packages/rails.sh"
  safe_source "packages/nvm.sh"
  safe_source "packages/node.sh"
}

# Function to consolidate post-installation scripts
post_install() {
  echo "Running post-install scripts..."

  if is_termux; then
    /etc/init.d/postgresql start
  fi

  echo "Post-installation steps completed."
}

# Run pipeline
prepare
install_packages
post_install

