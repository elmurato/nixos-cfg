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
    powerManagement.finegrained = true; # Keeps the card asleep when idling to save battery
    #preserveVideoMemory = true; # Saves VRAM during standby (might be needed for the dock)
  };

  networking.hostName = "thinkpad-p14s-gen2i";
  
  services.fprintd.enable = true; # Enable fingerprint reader
  services.fwupd.enable = true; # Enable BIOS and firmware updates via GNOME software center
  services.switcherooControl.enable = true; # GPU selection helper
  services.thermald.enable = true; # Intel CPU throttling fix

  # Prevent the CPU from drawing excessive power and reaching 100°C
  services.throttled = {
    enable = true;
    extraConfig = ''
      [GENERAL]
      Enabled: True

      [AC]
      Update_Rate_s: 5
      PL1_Tdp_W: 28
      PL1_Duration_s: 28
      PL2_Tdp_W: 35
      PL2_Duration_S: 0.002
      Trip_Temp_C: 90

      [BATTERY]
      Update_Rate_s: 30
      PL1_Tdp_W: 15
      PL1_Duration_s: 28
      PL2_Tdp_W: 25
      PL2_Duration_S: 0.002
      Trip_Temp_C: 85
    '';
  };        
  services.xserver.videoDrivers = [ "nvidia" "displaylink" "modesetting" ];
}
