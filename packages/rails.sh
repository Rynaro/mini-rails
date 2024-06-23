#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

prepare_package() {
  if is_termux; then
    return
  fi

  sudo apt install -y libpq-dev
}

install_package() {
  if is_termux; then
    echo "Rails will be installed inside the proot-distro for better lib support!"
    return
  fi

  if command_exists ruby; then
    echo "Installing Bundler and Rails gems..."
    gem install bundler
    gem install rails
    rbenv rehash
  else
    echo 'Any Ruby version should be installed prior having Rails being installed'
  fi
}

prepare_package
install_package

