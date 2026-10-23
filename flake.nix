{
  description = "Support different hardware configurations in one repo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, nixos-hardware, ...}@inputs: {
    nixosConfigurations = {

      "thinkpad-p14s-gen2i" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit plasma-manager; };
        modules = [ 
          nixos-hardware.nixosModules.lenovo-thinkpad-p14s-intel-gen2
          ./hosts/thinkpad-p14s-gen2i
          home-manager.nixosModules.home-manager
        ];
      };

      "nixos-vm" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit plasma-manager; };
        modules = [ 
          ./hosts/nixos-vm
          home-manager.nixosModules.home-manager
        ];
      };

    };
  };
}
      
    
