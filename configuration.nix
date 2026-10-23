# /etc/nixos/configuration.nix
{ config, lib, pkgs, plasma-manager, ... }:

let
  desktopEnvironment = "kde";
in
assert builtins.elem desktopEnvironment [ "gnome" "kde" ];
{
  imports =
    [
      ./home-manager.nix
    ] ++ lib.optional (desktopEnvironment == "gnome") ./home-manager-gnome.nix
      ++ lib.optional (desktopEnvironment == "kde") ./home-manager-kde.nix;

  home-manager.sharedModules = lib.optional (desktopEnvironment == "kde")
    plasma-manager.homeModules.plasma-manager;

  xdg.portal.config =
    if desktopEnvironment == "kde" then {
      kde.default = [ "kde" "gtk" ];
    } else {
      gnome.default = [ "gnome" "gtk" ];
    };

  # Disable fprintd in plasma login manager (broken)
  security.pam.services = lib.optionalAttrs (desktopEnvironment == "kde") {
    plasmalogin.rules.auth.login.modulePath = lib.mkForce "plasma-login-no-fprint";
    "plasma-login-no-fprint" = {
      useDefaultRules = true;
      fprintAuth = false;
      kwallet.enable = true;
    };
  };

  # Nix settings
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true; 
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0;
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
  };
  
  # Networking
  networking = {
    networkmanager.enable = true;
    # search = [ "abcxyz.ts.net" ]; # TODO: sops or someting else to store Tailnet name
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Time zone
  time.timeZone = "Europe/Berlin";

  # Internationalisation properties
  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  # List of services
  services = {
    # Desktop environment
    displayManager.gdm.enable = desktopEnvironment == "gnome";
    desktopManager.gnome.enable = desktopEnvironment == "gnome";
    fwupd.enable = true; # Enable BIOS and firmware updates
    gnome.gcr-ssh-agent.enable = desktopEnvironment == "gnome";
    displayManager.plasma-login-manager.enable = desktopEnvironment == "kde";
    desktopManager.plasma6.enable = desktopEnvironment == "kde";
    udisks2.enable = true; # Enable storage information

    # flatpak.enable = true;
    # openssh.enable = true;  # Enable the OpenSSH daemon.

    # Enable CUPS to print documents
    printing.enable = true;

    # Enable sound with pipewire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      # media-session.enable = true;
    };

    tailscale.enable = true;

    # X11 windowing system
    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
    };
  };

  # Enable RealtimeKit (helps prevent audio crackling, dropouts, and latency problems)
  security.rtkit.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elmurato = {
    isNormalUser = true;
    description = "Murat";
    extraGroups = [
      "dialout"
      "docker"
      "input"
      "networkmanager"
      "vboxusers"
      "wheel"
    ];
  };
  
  environment = {
    # List of GNOME packages to exclude
    gnome.excludePackages = lib.optionals (desktopEnvironment == "gnome") (with pkgs; [
      epiphany
    ]);
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      dmidecode
      git
      htop
      killall
      mesa-demos
      nano
      pciutils
      usbutils
      wget
    ];
  };

  # List of system programs
  programs = {
    nix-ld.enable = true; # For VSCode
    ssh = {
      startAgent = desktopEnvironment == "kde";
      askPassword = if desktopEnvironment == "kde" then "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass" else "";
      extraConfig = ''
        AddKeysToAgent yes # TODO: Remvoe for GNOME?
      '';
    };
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraProfile = ''
          export XCURSOR_PATH="${pkgs.adwaita-icon-theme}/share/icons''${XCURSOR_PATH:+:$XCURSOR_PATH}"
        '';
      };
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";
}
