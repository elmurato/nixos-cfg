# /etc/nixos/home-manager.nix
{ config, pkgs, ... }:

{
  home-manager.users.elmurato = { pkgs, ... }: let
    gnomeExtensionsList = with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      burn-my-windows
      compiz-alike-magic-lamp-effect
      compiz-windows-effect
      coverflow-alt-tab
      #dash2dock-lite
      dash-to-dock
      desktop-cube
      desktop-icons-ng-ding
      freon
      places-status-indicator
      removable-drive-menu
      tiling-assistant
    ];
  in {
    nixpkgs.config.allowUnfree = true;
    home = {
      stateVersion = config.system.stateVersion;
      # User specific packages
      packages = (with pkgs; [
        bitwarden-desktop
        dconf-editor
        discord
        gimp
        gnome-system-monitor
        gnome-tweaks
        google-chrome
        gparted
        libreoffice-fresh
        nextcloud-client
        prismlauncher # Alternative Minecraft launcher
        spotify
        vlc
      ]) ++ gnomeExtensionsList; # User specific GNOME extensions
    };

    # User specific programs
    programs = {
      vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          continue.continue
            ms-vscode.cpptools         
          ms-vscode-remote.remote-containers
          eamodio.gitlens 
          jnoortheen.nix-ide
        ];
      };

      git = {
        enable = true;
        settings.user = {
          name = "elmurato";
          email = "1382097+elmurato@users.noreply.github.com";
        };
      };
    };
    
    # GNOME settings via dconf
    dconf.settings = {
      # Desktop background
      "org/gnome/desktop/background" = {
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jxl";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jxl";
      };
      # Desktop interface
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        clock-show-weekday = true;        
        enable-hot-corners = true;
        gtk-enable-primary-paste = true;
        show-battery-percentage = true;
      };
      # Desktop window manager
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
      };
      # Extensions
      "org/gnome/shell" = {
        always-show-log-out = true;
        enabled-extensions = map (ext: ext.extensionUuid) gnomeExtensionsList;
        favorite-apps = [
          "google-chrome.desktop"
          "spotify.desktop"
          "discord.desktop"
          "code.desktop"
          "steam.desktop"
          "org.gnome.Console.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };
      # Extension settings
      "org/gnome/shell/extensions/burn-my-windows" = {
        active-profile = "'/home/elmurato/.config/burn-my-windows/profiles/default.conf'";
      };
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur = true;
        brightness = 0.6;
	      override-background = true;
        sigma = 30;
        static-blur = false;
	      style-dash-to-dock = 0;
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        animate-show-apps = true;
        # background-opacity = 0.8;
        dash-max-icon-size = 32;
	      disable-overview-on-startup = true;
        dock-fixed = false;
	      dock-position = "BOTTOM";
        extend-height = false;
        height-fraction = 0.90;
        intellihide = true;
        intellihide-mode = "FOCUS-APPLICATION-WINDOWS";
	      # max-alpha = 0.80;
        running-indicator-style = "DOTS";
        transparency-mode = "DEFAULT";
      };
      "org/gnome/shell/extensions/dash2dock-lite" = {
        autohide-dash = true;
        blur-background = true;
        border-radius = 0.0;
        dock-padding = 1.0;
        edge-distance = 0.33;
        icon-size = 0.15;
        lamp-app-animation = true;
        open-app-animation = true;
        running-indicator-size = 1;
        running-indicator-style = 7;
      };
      "org/gnome/shell/extensions/freon" = {
        hot-sensors = [ "CPU" ];
      };
      # Key bindings
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Open terminal";
        command = "kgx";
        binding = "<Primary><Alt>t";
      };
    };
    xdg.configFile."burn-my-windows/profiles/default.conf".text = ''
      [burn-my-windows-profile]
      fire-enable-effect=false
      broken-glass-enable-effect=false
      doom-enable-effect=false
      apparition-enable-effect=false
      aura-glow-enable-effect=false
      energize-a-enable-effect=false
      energize-b-enable-effect=false
      focus-enable-effect=false
      glide-enable-effect=false
      glitch-enable-effect=false
      hexagon-enable-effect=false
      incinerate-enable-effect=false
      matrix-enable-effect=false
      mushroom-enable-effect=false
      paint-brush-enable-effect=false
      pixelate-enable-effect=false
      pixel-wheel-enable-effect=false
      pixel-wipe-enable-effect=false
      portal-enable-effect=false
      rgbwarp-enable-effect=false
      snap-enable-effect=false
      team-rocket-enable-effect=false
      trex-enable-effect=false
      tv-enable-effect=true
      tv-glitch-enable-effect=false
      wisps-enable-effect=false
    '';
  };
}
