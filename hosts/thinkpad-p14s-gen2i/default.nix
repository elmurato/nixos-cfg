{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    displaylink # For HDMI via HP USB-C Dock G2
    nvme-cli # For reading NVMe SSD temperature in Freon
  ];

  hardware.nvidia = {
    nvidiaSettings = true; # Enable nvidia-settings tool 
  };

  networking.hostName = "thinkpad-p14s-gen2i";
  
  services.fprintd.enable = true; # Enable fingerprint reader
  services.fwupd.enable = true; # Enable BIOS and firmware updates via GNOME software center
  services.switcherooControl.enable = true; # GPU selection helper
  services.thermald.enable = true; # Intel CPU throttling fix
  services.xserver.videoDrivers = [ "nvidia" "displaylink" "modesetting" ];
}
