#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

# Function to prompt user for PostgreSQL credentials
prompt_postgres_credentials() {
  read -p "Enter PostgreSQL user (default: user): " input_pg_user
  read -p "Enter PostgreSQL password (default: pswd): " input_pg_password

  PG_USER=${input_pg_user:-user}
  PG_PASSWORD=${input_pg_password:-pswd}
}

install_package() {
  pkg install postgresql
}

configure_package() {
  mkdir -p $PREFIX/var/lib/postgresql
  initdb $PREFIX/var/lib/postgresql

  pg_ctl -D $PREFIX/var/lib/postgresql start

  createuser --superuser postgres
  psql -U postgres -c " CREATE DATABASE postgres WITH OWNER postgres;"

  prompt_postgres_credentials
  # Switch to the postgres superuser to create a new user and set the password
  createuser -U postgres $PG_USER
  psql -U postgres -c "ALTER USER $PG_USER WITH PASSWORD '$PG_PASSWORD';"

  pg_ctl -D $PREFIX/var/lib/postgresql stop

  echo "# Mini-Rails !--> Postgresql" >> ~/.potions/.zsh_aliases
  echo "alias pg_start='pg_ctl -D \$PREFIX/var/lib/postgresql start'" >> ~/.potions/.zsh_aliases
  echo "alias pg_stop='pg_ctl -D \$PREFIX/var/lib/postgresql stop'" >> ~/.potions/.zsh_aliases
}

install_package
configure_package

