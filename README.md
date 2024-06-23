<img src="https://github.com/Rynaro/mini-rails/assets/5271543/9a2350e1-1ffd-4f6f-8978-450b57bc67b0" height="150" />

# Mini Rails

**Full Rails Environment Plugin for Debian Proot**

## Overview

Mini Rails is a plugin designed to set up a full Rails development environment within a Debian Proot distribution. It automates the installation and configuration of Ruby on Rails, along with its dependencies, to streamline the setup process for developers.

## Installation

1. Ensure you have Potions set up. Follow the [Potions installation guide](https://github.com/Rynaro/potions).
2. Add the plugin to your `plugins.txt` in the Potions root folder:
    ```txt
    Rynaro/mini-rails
    ```

3. Run the plugin management script:
    ```sh
    ./plugins.sh install
    ```

Since it's a hybrid script, you should need to run the plugin install in the Termux environment to get the Android patched Postgres version. And then run it again inside the debian proot-distro to get Ruby, Rails, Node installed!

## Components

- **install.sh**: Handles the installation of Ruby on Rails and its dependencies.
- **utilities.sh**: Contains utility functions used during the installation process.
- **packages/**: Directory containing scripts for package-specific setups.

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

For more information, visit the [Mini Rails GitHub page](https://github.com/Rynaro/mini-rails).
