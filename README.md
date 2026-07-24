# NixOS Configuration Repository

## 🚀 Overview

After using **Arch Linux** for a long time I got to know **NixOS** and decided to give it a try.
This repository contains my complete, version-controlled configuration for it.

The goal of this repository is to provide a fully reproducible and declarative environment setup. By managing my system configuration entirely through Nix expressions, I ensure that my machine state can be reliably reproduced on any hardware, minimizing the risk associated with manual changes and drift over time.

## ✨ Key Features

1.  **Declarative Management**: Every aspect of the system—from desktop environment packages (e.g., Wayland compositors, window managers) to service settings (e.g., SSH keys, firewalls)—is defined in code (`.nix` files).
2.  **Reproducibility**: Running `nixos-rebuild` with this configuration ensures that the entire system state is reproducible and consistent across rebuilds.
3.  **Version Control**: Changes are tracked via Git, allowing for easy rollback to previous stable states and meticulous auditing of system modifications.
4.  **Multi Hardware Support**: One central configuration, which supports multiple computers and notebooks.

## ⚙️ Getting Started

To deploy this configuration onto a NixOS machine, follow these general steps:

1.  **Create User Configuration Folder**
    ```bash
    mkdir ~/.config/nixos
    ```

2.  **Clone the Repository**
    - Enter a nix-shell with git:
    ```bash
    nix-shell -p git
    ```
    - Inside the nix-shell switch to the configuration folder and clone the repository:
    ```bash
    cd ~/.config/nixos
    git clone https://github.com/elmurato/nixos-cfg.git .
    ```

3.  **Adapt User Name**
    - Search for `elmurato` in `configuration.nix` and `home-manager.nix` and replace it with your own username.

4.  **Remove Default Configuration and Create Symlink**
    > ⚠️ **Warning:** This permanently deletes `/etc/nixos`. If you have existing configuration files you want to keep, back them up first:
    > ```bash
    > cp -r /etc/nixos ~/nixos-backup
    > ```
    ```bash
    sudo rm -r /etc/nixos
    sudo ln -s ~/.config/nixos /etc/nixos
    ```

5.  **Select Hardware, Rebuild and Apply**
    - On first rebuild, pass the hostname of the target hardware. Example ThinkPad P14s Gen2i:
    ```bash
    sudo nixos-rebuild switch --flake /etc/nixos#thinkpad-p14s-gen2i
    ```
    - Once the hostname is set, rebuild as usual from that point on:
    ```bash
    sudo nixos-rebuild switch --flake /etc/nixos
    ```

## 📂 Repository Structure

```
nixos-cfg/
├── configuration.nix
├── flake.nix
├── flake.lock
├── home-manager.nix
└── hosts/
    ├── thinkpad-p14s-gen2i/
    │   ├── default.nix
    │   └── hardware-configuration.nix
    └── nixos-vm/
        ├── default.nix
        └── hardware-configuration.nix
```

| File / Directory | Description |
| :--- | :--- |
| `configuration.nix` | Primary system configuration. Defines global OS settings: networking, user accounts, installed packages, kernel options, and services. Main entry point for `nixos-rebuild`. |
| `flake.nix` | Flakes entry point. Declares all external inputs (e.g., `nixpkgs`, `home-manager`) and exposes the NixOS configurations for each host as outputs. Replaces the traditional `nix-channel` approach. |
| `flake.lock` | Auto-generated lock file that pins every flake input to an exact git revision, guaranteeing fully reproducible builds across machines and time. Do not edit manually. |
| `home-manager.nix` | User-specific configuration. Manages shell settings (Oh My Zsh, aliases), user-scoped applications, desktop customizations (GTK themes, terminal emulator), and dotfiles. |
| `hosts/thinkpad-p14s-gen2i/default.nix` | Hardware-specific customizations for the ThinkPad P14s Gen2i. |
| `hosts/thinkpad-p14s-gen2i/hardware-configuration.nix` | Auto-generated hardware configuration for the ThinkPad P14s Gen2i. |
| `hosts/nixos-vm/default.nix` | Hardware-specific customizations for the VM. |
| `hosts/nixos-vm/hardware-configuration.nix` | Auto-generated hardware configuration for the VM. |