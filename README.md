# NixOS Configuration Repository

## 🚀 Overview

After using **Arch Linux** for a long time I got to know **NixOS** and decided to give it a try.
This repository contains my complete, version-controlled configuration for it.

The goal of this repository is to provide a fully reproducible and declarative environment setup. By managing my system configuration entirely through Nix expressions, I ensure that my machine state can be reliably reproduced on any hardware, minimizing the risk associated with manual changes and drift over time.

## ✨ Key Features

1.  **Declarative Management**: Every aspect of the system—from desktop environment packages (e.g., Wayland compositors, window managers) to service settings (e.g., SSH keys, firewalls)—is defined in code (`.nix` files).
2.  **Reproducibility**: Running `nixos-rebuild` with this configuration ensures that the entire system state is identical across different machines running the same hardware profile.
3.  **Version Control**: Changes are tracked via Git, allowing for easy rollback to previous stable states and meticulous auditing of system modifications.

## ⚙️ Getting Started

To deploy this configuration onto a NixOS machine, follow these general steps:

1.  **Create and Enter User Configuration Folder**
    ```bash
    mkdir ~/.config/nixos
    cd ~/.config/nixos
    ```

2.  ** Remove Default Configuration and Create Symlink**
    ```bash
    sudo rm -r /etc/nixos
    sudo ln -s ~/.config/nixos /etc/nixos
    ```

3.  **Clone the Repository**:
    ```bash
    git clone https://github.com/elmurato/nixos-cfg.git .
    ```

4.  **Adapt Configuration**:
    - Replace the username in `configuration.nix` and `home-manager.nix`.
    - If you are deploying this to new hardware or need to adjust specific parameters (like machine names or network setups), edit the file `hardware-configuration.nix`.

5.  **Rebuild and Apply**:
    Execute the standard NixOS build process using your configured flake/module structure:
    ```bash
    sudo nixos-rebuild switch
    ```

## 📂 Repository Structure

| Directory/File | Description |
| :--- | :--- |
| `configuration.nix` | The primary system configuration file. It defines global settings for the entire operating system, including services like networking, user accounts, installed packages, and kernel options. This is the main entry point when building the base OS environment via `nixos-rebuild`. |
| `hardware-configuration.nix` | Machine-specific settings, such as local network configuration, partition layouts, and kernel modules. | 
| `home-manager.nix` | This file manages user-specific configurations that extend the base NixOS setup. It handles non-system-wide aspects of the user's experience, such as shell settings (e.g., Oh My Zsh, specific aliases), installed applications only for the user, desktop customizations (like GTK theme settings or preferred terminal emulator), and managing dotfiles to ensure personal configurations are reproducible across different machines running this NixOS base setup. |
