{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    nvme-cli # For reading NVMe SSD temperature in Freon
  ];

  hardware.nvidia = {
    nvidiaSettings = true; # Enable nvidia-settings tool 
  };

  networking.hostName = "thinkpad-p14s-gen2i";
  
  services.fwupd.enable = true; # Enable BIOS and firmware updates via GNOME software center
  services.thermald.enable = true; # Intel CPU throttling fix
  services.fprintd.enable = true; # Enable fingerprint reader
}