# /etc/nixos/home-manager.nix
{ config, pkgs, ... }:

{
  home-manager.users.elmurato = { pkgs, ... }: {
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
        discord
        fastfetch
        gimp
        google-chrome
        gparted
        libreoffice
        nextcloud-client
        prismlauncher # Alternative Minecraft launcher
        spotify
        vlc
      ]);
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
          eamodio.gitlens 
          github.copilot
          github.copilot-chat
          jnoortheen.nix-ide
          ms-vscode.cpptools   
          ms-vscode-remote.remote-containers
        ];
      };
    };
    
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
