#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

# Default PostgreSQL user credentials
PG_USER=${PG_USER:-defaultuser}
PG_PASSWORD=${PG_PASSWORD:-defaultpassword}

# Function to prompt user for PostgreSQL version
prompt_postgres_version() {
  echo "Available PostgreSQL versions:"
  echo "1) PostgreSQL 12"
  echo "2) PostgreSQL 13"
  echo "3) PostgreSQL 14"
  echo "4) PostgreSQL 15"
  echo "5) PostgreSQL 16"

  read -p "Please select the PostgreSQL version to install (1-5): " version_choice

  POSTGRES_VERSION="System"
  case $version_choice in
    1) POSTGRES_VERSION="12" ;;
    2) POSTGRES_VERSION="13" ;;
    3) POSTGRES_VERSION="14" ;;
    4) POSTGRES_VERSION="15" ;;
    5) POSTGRES_VERSION="16" ;;
    *) echo "Invalid selection. Defaulting to PostgreSQL from Original Debian Bookworm repositories." ;;
  esac
}

# References from: https://www.postgresql.org/download/linux/debian
configure_ppa() {
  # Import the repository signing key:
  sudo install -d /usr/share/postgresql-common/pgdg
  sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

  # Create the repository configuration file:
  sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
}

# Function to prompt user for PostgreSQL credentials
prompt_postgres_credentials() {
  read -p "Enter PostgreSQL user (default: user): " input_pg_user
  read -p "Enter PostgreSQL password (default: pswd): " input_pg_password

  PG_USER=${input_pg_user:-user}
  PG_PASSWORD=${input_pg_password:-pswd}
}

prepare_package() {
  sudo apt install -y curl ca-certificates
  prompt_postgres_version
  prompt_postgres_credentials
  configure_ppa
  update_repositories
}

# Function to install PostgreSQL
install_package() {
  if command_exists psql && psql --version | grep -q " $POSTGRES_VERSION."; then
    echo "PostgreSQL in any version is already installed."
  else
    echo "Installing PostgreSQL $POSTGRES_VERSION..."
    if [ "$POSTGRES_VERSION" == "System" ]; then
      sudo apt install -y postgresql
      POSTGRES_VERSION='16'
    else
      sudo apt install -y postgresql-$POSTGRES_VERSION
    fi
  fi
}

configure_package() {
  echo "Configuring PostgreSQL to accept connections from 0.0.0.0..."

  if sudo pg_lsclusters | grep -q "$POSTGRES_VERSION main"; then
    echo "PostgreSQL cluster for version $POSTGRES_VERSION already exists."
  else
    echo "Creating new PostgreSQL cluster for version $POSTGRES_VERSION..."
    sudo pg_createcluster $POSTGRES_VERSION main --start
  fi

  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf
  sudo bash -c "echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf"

  echo "Creating PostgreSQL user..."
  sudo -u postgres psql -c "CREATE USER $PG_USER WITH PASSWORD '$PG_PASSWORD';"
  sudo -u postgres psql -c "ALTER USER $PG_USER WITH SUPERUSER;"
}

start_postgres_proot() {
  echo "Starting PostgreSQL..."
  sudo pg_ctlcluster $POSTGRES_VERSION main start
}

prepare_package
install_package
configure_package
start_postgres_proot

