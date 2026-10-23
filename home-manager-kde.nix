{ pkgs, ... }:

{
  home-manager.users.elmurato = { pkgs, ... }: {
    home.packages = with pkgs.kdePackages; [
      dolphin
      konsole
      spectacle
    ];

    programs.plasma = {
      enable = true;

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        wallpaper = ./assets/wallpapers/RDSTR.jpg;
      };

      panels = [
        {
          location = "top";
          floating = true;
          height = 46;
          widgets = [
            {
              kickoff = {
                icon = "nix-snowflake";
                sortAlphabetically = true;
                compactDisplayStyle = true;
                favoritesDisplayMode = "list";
                showButtonsFor = "powerAndSession";
                settings.General.highlightNewlyInstalledApps = false;
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              name = "org.kde.plasma.pager";
              config.General.showWindowIcons = true;
            }
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.panelspacer"
            {
              digitalClock.date.format = "longDate";
            }
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            "org.kde.plasma.showdesktop"
            "org.kde.plasma.marginsseparator"
            {
              name = "org.kde.plasma.lock_logout";
              config.General.actionsOrder = "lockScreen,switchUser,requestShutDown,requestReboot,requestLogout,requestLogoutScreen,suspendToRam,suspendToDisk";
            }
          ];
        }
        {
          location = "bottom";
          floating = true;
          height = 64;
          lengthMode = "fit";
          hiding = "dodgewindows";
          widgets = [
            {
              iconTasks = {
                appearance.rows.multirowView = "never";
                launchers = [
                  "applications:chrome-mgbbdlbfcgckafggckgliakblcpcoaid-Default.desktop"
                  "preferred://browser"
                  "applications:spotify.desktop"
                  "applications:discord.desktop"
                  "applications:code.desktop"
                  "preferred://filemanager"
                  "applications:org.kde.konsole.desktop"
                  "applications:systemsettings.desktop"
                ];
              };
            }
          ];
        }
      ];

      kwin = {
        virtualDesktops = {
          number = 4;
          rows = 1;
        };
        tiling = {
          padding = 4;
          layout = {
            id = "2529a594-0af1-4664-8805-898c135ce5f2";
            tiles = {
              layoutDirection = "horizontal";
              tiles = [
                { width = 0.25; }
                { width = 0.5; }
                { width = 0.25; }
              ];
            };
          };
        };
      };

      shortcuts.kwin = {
        Cube = "Meta+C";
        "Edit Tiles" = "Meta+T";
        "Grid View" = "Meta+G";
        Overview = "Meta+W";
        "Switch One Desktop to the Left" = "Ctrl+Alt+Left";
        "Switch One Desktop to the Right" = "Ctrl+Alt+Right";
      };

      configFile = {
        kdeglobals = {
          "ColorEffects:Disabled" = {
            Color = "56,56,56";
            ColorAmount = 0;
            ColorEffect = 0;
            ContrastAmount = 0.65;
            ContrastEffect = 1;
            IntensityAmount = 0.1;
            IntensityEffect = 2;
          };
          "ColorEffects:Inactive" = {
            ChangeSelectionColor = true;
            Color = "112,111,110";
            ColorAmount = 0.025;
            ColorEffect = 2;
            ContrastAmount = 0.1;
            ContrastEffect = 2;
            Enable = false;
            IntensityAmount = 0;
            IntensityEffect = 0;
          };
          "Colors:Button" = {
            BackgroundAlternate = "190,13,14";
            BackgroundNormal = "41,44,48";
            DecorationFocus = "255,0,0";
            DecorationHover = "255,0,0";
            ForegroundActive = "255,0,0";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "255,186,186";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Complementary" = {
            BackgroundAlternate = "30,87,116";
            BackgroundNormal = "32,35,38";
            DecorationFocus = "255,0,0";
            DecorationHover = "255,0,0";
            ForegroundActive = "255,0,0";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "255,186,186";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Header" = {
            BackgroundAlternate = "32,35,38";
            BackgroundNormal = "41,44,48";
            DecorationFocus = "255,0,0";
            DecorationHover = "255,0,0";
            ForegroundActive = "255,0,0";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "255,186,186";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Header/Inactive" = {
            BackgroundAlternate = "41,44,48";
            BackgroundNormal = "32,35,38";
            DecorationFocus = "61,174,233";
            DecorationHover = "61,174,233";
            ForegroundActive = "61,174,233";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "29,153,243";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Selection" = {
            BackgroundAlternate = "184,6,7";
            BackgroundNormal = "184,6,7";
            DecorationFocus = "255,0,0";
            DecorationHover = "255,0,0";
            ForegroundActive = "255,0,0";
            ForegroundInactive = "255,255,255";
            ForegroundLink = "186,0,0";
            ForegroundNegative = "176,55,69";
            ForegroundNeutral = "198,92,0";
            ForegroundNormal = "255,255,255";
            ForegroundPositive = "23,104,57";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Tooltip" = {
            BackgroundAlternate = "32,35,38";
            BackgroundNormal = "41,44,48";
            DecorationFocus = "255,0,0";
            DecorationHover = "255,0,0";
            ForegroundActive = "255,0,0";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "255,186,186";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:View" = {
            BackgroundAlternate = "29,31,34";
            BackgroundNormal = "20,22,24";
            DecorationFocus = "255,0,0";
            DecorationHover = "255,0,0";
            ForegroundActive = "255,0,0";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "255,186,186";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Window" = {
            BackgroundAlternate = "41,44,48";
            BackgroundNormal = "32,35,38";
            DecorationFocus = "255,0,0";
            DecorationHover = "255,0,0";
            ForegroundActive = "255,0,0";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "255,186,186";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          General = {
            AccentColor = "255,0,0";
            LastUsedCustomAccentColor = "255,0,0";
          };
          KDE = {
            LookAndFeelPackage = "org.kde.breezedark.desktop";
            contrast = 4;
            frameContrast = 0.2;
          };
          "KFileDialog Settings" = {
            "Allow Expansion" = false;
            "Automatically select filename extension" = true;
            "Breadcrumb Navigation" = false;
            "Decoration position" = 2;
            "Show Full Path" = false;
            "Show Inline Previews" = true;
            "Show Preview" = false;
            "Show Speedbar" = true;
            "Show hidden files" = false;
            "Sort by" = "Name";
            "Sort directories first" = true;
            "Sort hidden files last" = false;
            "Sort reversed" = false;
            "Speedbar Width" = 192;
            "View Style" = "DetailTree";
          };
          WM = {
            activeBackground = "39,44,49";
            activeBlend = "252,252,252";
            activeForeground = "252,252,252";
            inactiveBackground = "32,36,40";
            inactiveBlend = "161,169,177";
            inactiveForeground = "161,169,177";
          };
        };
        kwinrc = {
          "Effect-diminactive".Strength = 75;
          "Effect-translucency".Inactive = 80;
          Plugins = {
            cubeEnabled = true;
            diminactiveEnabled = true;
            glideEnabled = true;
            magiclampEnabled = true;
            scaleEnabled = false;
            sheetEnabled = true;
            squashEnabled = false;
            translucencyEnabled = true;
            wobblywindowsEnabled = true;
          };
          TabBox.LayoutName = "flipswitch";
          Xwayland.Scale = 1;
        };
        dolphinrc = {
          General.Version = 202;
          "KFileDialog Settings" = {
            "Places Icons Auto-resize" = false;
            "Places Icons Static Size" = 22;
          };
          MainWindow.MenuBar = "Disabled";
        };
        baloofilerc = {
          General.dbVersion = 2;
        };
        "plasma-localerc".Formats.LANG = "de_DE.UTF-8";
      };
    };
  };
}