{ pkgs, ... }:

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
    home.packages = with pkgs; [
      dconf-editor
      gnome-system-monitor
      gnome-tweaks
    ] ++ gnomeExtensionsList;

    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "file://${./assets/wallpapers/RDSTR.jpg}";
        picture-uri-dark = "file://${./assets/wallpapers/RDSTR.jpg}";
        picture-options = "zoom";
      };
      "org/gnome/desktop/interface" = {
        accent-color = "red";
        color-scheme = "prefer-dark";
        clock-show-weekday = true;
        enable-hot-corners = true;
        gtk-enable-primary-paste = true;
        show-battery-percentage = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
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
        running-indicator-style = "DOTS";
        transparency-mode = "DEFAULT";
      };
      "org/gnome/shell/extensions/freon" = {
        hot-sensors = [ "CPU" ];
      };
      "org/gnome/shell/extensions/tiling-assistant" = {
        movement-cycle-behavior = 1;
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
  };
}