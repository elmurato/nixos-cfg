{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  networking.hostName = "thinkpad-p14s-gen2i";
  services.fwupd.enable = true; # Enable BIOS and firmware updates via GNOME software center
  services.thermald.enable = true; # Intel CPU throttling fix
  services.fprintd.enable = true; # Enable fingerprint reader
}