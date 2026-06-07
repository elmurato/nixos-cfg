# /etc/nixos/home-manager.nix
{ config, pkgs, ... }:

{
  home-manager.users.elmurato = { pkgs, ... }: {
    home.stateVersion = config.system.stateVersion;
    nixpkgs.config.allowUnfree = true;

    # User specific packages
    home.packages = (with pkgs; [
      dconf-editor
      #enpass
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
      dash-to-dock
      desktop-cube
      desktop-icons-ng-ding
      forge
      places-status-indicator
    ]);

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
      # Desktop interface
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = true;
        clock-show-weekday = true;
      };
      # Desktop window manager
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
      };
      # Extensions
      "org/gnome/shell" = {
        enabled-extensions = map (ext: ext.extensionUuid) (with pkgs.gnomeExtensions; [
          appindicator
          blur-my-shell
          compiz-alike-magic-lamp-effect
          compiz-windows-effect
          coverflow-alt-tab
          dash-to-dock
          desktop-cube
          desktop-icons-ng-ding
          forge
          places-status-indicator
        ]);
      };
      # Extension settings
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur = true;
        brightness = 0.6;
        sigma = 30;
        pipeline = "dynamic";
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        background-opacity = 0.0;
        dash-max-icon-size = 32;
        dock-fixed = false;
        dock-position = "BOTTOM";
        intellihide = true;
        transparency-mode = "FIXED";
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
        binding = "<Super>t";
      };
    };
  };
}
