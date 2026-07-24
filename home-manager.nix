# /etc/nixos/home-manager.nix
{ config, pkgs, ... }:

{
  home-manager.users.elmurato = { pkgs, ... }: {
    home.stateVersion = config.system.stateVersion;
    nixpkgs.config.allowUnfree = true;

    # User specific packages
    home.packages = (with pkgs; [
      dconf-editor
      enpass
      gimp
      gnome-system-monitor
      gnome-tweaks
      google-chrome
      gparted
      libreoffice-fresh
      nextcloud-client
      vlc
    # User specific GNOME extensions
    ]) ++ (with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      compiz-alike-magic-lamp-effect
      compiz-windows-effect
      coverflow-alt-tab
      dash2dock-lite
      desktop-cube
      desktop-icons-ng-ding
      # forge
      freon
      places-status-indicator
      removable-drive-menu
    ]);

    xdg.desktopEntries.enpass = {
      name = "Enpass";
      exec = "env QT_QPA_PLATFORM=xcb QT_STYLE_OVERRIDE=fusion XDG_CURRENT_DESKTOP=KDE ${pkgs.enpass}/bin/Enpass %U";
      icon = "enpass";
      categories = [ "Utility" "Security" ];
      mimeType = [ "x-scheme-handler/enpasscard" "x-scheme-handler/enpassauth" ];
      settings = {
        DBusActivatable = "false";
      };
    };

    # User specific programs
    programs.vscode = {
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

    programs.git = {
      enable = true;
      settings.user = {
        name = "elmurato";
        email = "1382097+elmurato@users.noreply.github.com";
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
        enabled-extensions = map (ext: ext.extensionUuid) (with pkgs.gnomeExtensions; [
          appindicator
          blur-my-shell
          compiz-alike-magic-lamp-effect
          compiz-windows-effect
          coverflow-alt-tab
          dash2dock-lite
          desktop-cube
          desktop-icons-ng-ding
          # forge
          freon
          places-status-indicator
          removable-drive-menu
        ]);
        favorite-apps = [
          "google-chrome.desktop"
          "code.desktop"
          "steam.desktop"
          "org.gnome.Console.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };
      # Extension settings
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur = true;
        brightness = 0.6;
        sigma = 30;
        static-blur = false;
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
        hot-sensors = [
          "CPU"
          "BAT0 Power"
        ];
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
  };
}