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

## 🖥️ Desktop Environment

The repository includes declarative configurations for both GNOME and KDE Plasma. Select the desktop environment by setting `desktopEnvironment` in `configuration.nix`.

### GNOME

I'm using a macOS-like GNOME with good old Compiz animations/effects.

**Main extensions:**

- **Dock:** 
  - Blur my Shell
  - Dash to Dock
- **Classic Compiz effects:**
  - Burn My Windows
  - Coverflow Alt-Tab
  - Compiz alike Magic Lamp Effect
  - Compiz Windows Effect
  - Desktop Cube
- **Workflow and system tools:** 
  - AppIndicator
  - Desktop Icons NG (DING)
  - Freon
  - Places Status Indicator
  - Removable Drive Menu
  - Tiling Assistant

### KDE Plasma

The KDE configuration uses a dark Breeze theme, floating top and bottom panels, and a custom KWin tiling layout. It also enables classic desktop effects such as the desktop cube, magic lamp, and wobbly windows, with shortcuts for virtual desktops and window management.

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
├── LICENSE
├── README.md
├── assets/
│   └── wallpapers/
│       └── RDSTR.jpg
├── configuration.nix        # Shared system configuration
├── flake.nix                # Flake outputs and host definitions
├── flake.lock               # Locked flake inputs
├── home-manager.nix         # Shared user environment
├── home-manager-gnome.nix   # GNOME settings and extensions
├── home-manager-kde.nix     # KDE Plasma settings
└── hosts/
    ├── thinkpad-p14s-gen2i/
    │   ├── default.nix      # ThinkPad host configuration
    │   └── hardware-configuration.nix
    └── nixos-vm/
        ├── default.nix      # VM host configuration
        └── hardware-configuration.nix
```

| File / Directory | Description |
| :--- | :--- |
| `LICENSE` | Repository license. |
| `README.md` | Setup instructions and repository documentation. |
| `assets/wallpapers/RDSTR.jpg` | Wallpaper configured by Home Manager for the desktop environments. |
| `configuration.nix` | Shared system settings, including networking, users, packages, boot options, and services. Each host imports this module. |
| `flake.nix` | Declares external inputs and exposes a NixOS configuration for each host. This is the entry point used by `nixos-rebuild --flake`. |
| `flake.lock` | Auto-generated lock file that pins each flake input to an exact revision for reproducible builds. Do not edit manually. |
| `home-manager.nix` | Shared user environment configuration for packages, shell settings, VS Code, and dotfiles. It is imported by `configuration.nix`. |
| `home-manager-gnome.nix` | GNOME desktop configuration and extensions. |
| `home-manager-kde.nix` | KDE Plasma desktop configuration. |
| `hosts/thinkpad-p14s-gen2i/default.nix` | ThinkPad host module. Imports the generated hardware configuration and shared system configuration, then adds host-specific settings. |
| `hosts/thinkpad-p14s-gen2i/hardware-configuration.nix` | Generated hardware configuration for the ThinkPad P14s Gen2i. |
| `hosts/nixos-vm/default.nix` | VM host module. Imports the generated hardware configuration and shared system configuration, then sets the host name. |
| `hosts/nixos-vm/hardware-configuration.nix` | Generated hardware configuration for the VM. |