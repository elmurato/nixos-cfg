{
  description = "Support different hardware configurations in one repo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ...}@inputs: {
    nixosConfigurations = {

      "thinkpad-p14s-gen2i" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          nixos-hardware.nixosModules.lenovo-thinkpad-p14s-intel-gen2
          ./hosts/thinkpad-p14s-gen2i
          home-manager.nixosModules.home-manager
        ];
      };

      "nixos-vm" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/nixos-vm
          home-manager.nixosModules.home-manager
        ];
      };

    };
  };
}
      
    
