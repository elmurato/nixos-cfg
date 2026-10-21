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
      dash-to-dock
      desktop-cube
      desktop-icons-ng-ding
      freon
      places-status-indicator
      removable-drive-menu
      tiling-shell
    ];
  in {
    nixpkgs.config.allowUnfree = true;
    home = {
      file = {
        ".nanorc".text = ''
          set autoindent
          set tabsize 2
          set tabstospaces
          set linenumbers
        '';
      };
      # User specific packages
      packages = (with pkgs; [
        bitwarden-desktop
        dconf-editor
        discord
        fastfetch
        gimp
        gnome-system-monitor
        gnome-tweaks
        google-chrome
        gparted
        libreoffice
        nextcloud-client
        prismlauncher # Alternative Minecraft launcher
        spotify
        vlc
      ]) ++ gnomeExtensionsList; # User specific GNOME extensions
      stateVersion = config.system.stateVersion;
    };

    # User specific programs
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
          clear      
          fastfetch
          echo ""
        '';
        shellAliases = {
          nix-switch = "sudo nixos-rebuild switch --flake /etc/nixos";
          nix-update = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake /etc/nixos";
          ll = "ls -lLa";
        };
      };
      git = {
        enable = true;
        settings.user = {
          name = "elmurato";
          email = "1382097+elmurato@users.noreply.github.com";
        };
      };
      starship = {
        enable = true;
        enableBashIntegration = true;
      };
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
    };
    
    # GNOME settings via dconf
    dconf.settings = {
      # GNOME desktop
      "org/gnome/desktop/background" = {
        picture-uri = "file://${./assets/wallpapers/RDSTR.jpg}";
        picture-uri-dark = "file://${./assets/wallpapers/RDSTR.jpg}";
        picture-options = "zoom";
      };
      "org/gnome/desktop/interface" = {
        accent-color = "red";  # Options: "blue", "teal", "green", "yellow", "orange", "red", "pink", "purple", "slate"
        color-scheme = "prefer-dark";
        clock-show-weekday = true;        
        enable-hot-corners = true;
        gtk-enable-primary-paste = true;
        show-battery-percentage = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
        # Löscht die nativen GNOME-Verknüpfungen für linkes/rechtes Kacheln
        toggle-tiled-left = [];
        toggle-tiled-right = [];
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [];
        toggle-tiled-right = [];
      };
      # GNOME extensions
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
      # GNOME extension settings
      "org/gnome/shell/extensions/burn-my-windows" = {
        active-profile = "'/home/elmurato/.config/burn-my-windows/profiles/default.conf'";
      };
      "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
        blur = false;
      };
      "org/gnome/shell/extensions/blur-my-shell/applications" = {
        blur = true;
        blur-on-focused = false;
        blur-on-overview = false;
        brightness = 1.0;
        dynamic-opacity = true;
        enable = true;
        enable-all = true;
        opacity = 175;
        pipeline = "pipeline_default";
        sigma = 30;
        static-blur = false;
      };
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur = true;
        brightness = 0.6;
	      override-background = true;
        sigma = 30;
        static-blur = false;
	      style-dash-to-dock = 0;
      };
      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        blur = false;
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        animate-show-apps = true;
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
      "org/gnome/shell/extensions/freon" = {
        hot-sensors = [ "CPU" ];
      };
      "org/gnome/shell/extensions/tiling-assistant" = {
        movement-cycle-behavior = 1; # 1 means 'Static'
      };
      "org/gnome/shell/extensions/tilingshell/keybindings" = {
        enable-autotiling = true; 
        enable-auto-resize = true; 
        enable-gaps = true;
        inner-gaps = 12;
        move-window-left = [ "<Super>Left" ];
        move-window-right = [ "<Super>Right" ];
        move-window-up = [ "<Super>Up" ];
        move-window-down = [ "<Super>Down" ];
        outer-gaps = 12;    
        snap-window-left = [ "<Super>Left" ];
        snap-window-right = [ "<Super>Right" ];
        snap-window-topleft = [ "<Super><Shift>Left" ];
        snap-window-topright = [ "<Super><Shift>Right" ];
        tweak-window-shadows = true; 
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
      tv-animation-time=500
    '';
    xdg.configFile."fastfetch/config.jsonc".text = ''
      {
        "$schema": "https://raw.githubusercontent.com/fastfetch-cli/fastfetch/refs/heads/dev/doc/json_schema.json",
        "modules": [
          "title",
          "separator",
          "host",
          "bios",
          "tpm",
          "break",
          "os",
          "kernel",
          "de",
          "wm",
          "terminal",
          "break",
          "cpu",
          "memory",
          "gpu",
          "physicaldisk",
          "disk",
          "battery",
          "poweradapter",
          "break",
          "datetime"
        ]
      }
  '';
  };
}
