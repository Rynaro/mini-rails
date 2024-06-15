#!/bin/bash

# Source utilities script
safe_source "$(dirname "$0")/../utilities.sh"

# Default PostgreSQL user credentials
PG_USER=${PG_USER:-defaultuser}
PG_PASSWORD=${PG_PASSWORD:-defaultpassword}

# Function to install PostgreSQL 14
install_package() {
  echo "Installing PostgreSQL 14..."
  sudo apt install -y postgresql-14
}

configure_package() {
  echo "Configuring PostgreSQL to accept connections from 0.0.0.0..."
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/14/main/postgresql.conf
  sudo bash -c "echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/14/main/pg_hba.conf"

  echo "Creating PostgreSQL user..."
  sudo -u postgres psql -c "CREATE USER $PG_USER WITH PASSWORD '$PG_PASSWORD';"
  sudo -u postgres psql -c "ALTER USER $PG_USER WITH SUPERUSER;"

}

install_package
configure_package
