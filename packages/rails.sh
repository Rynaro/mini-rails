#!/bin/bash

prepare_package() {
  sudo apt install -y libpq-dev
}

install_package() {
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
