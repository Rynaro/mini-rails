#!/bin/bash

# Function to prepare to install packages
prepare() {
  if is_debian_bookworm; then
    update_repositories
  else
    echo "This script is designed for Debian Bookworm."
    exit 1
  fi
}

# Function to install packages
install_packages() {
  echo "Installing Plugin: mini-rails..."
  safe_source "packages/postgres.sh"
  safe_source "packages/redis.sh"
  safe_source "packages/rbenv.sh"
  safe_source "packages/ruby.sh"
  safe_source "packages/rails.sh"
  safe_source "packages/nvm.sh"
  safe_source "packages/node.sh"
}

# Function to consolidate post-installation scripts
post_install() {
  echo "Running post-install scripts..."
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl enable redis-server
  sudo systemctl start redis-server
}

# Source utilities script
safe_source "$(dirname "$0")/utilities.sh"

# Run pipeline
prepare
install_packages
post_install

