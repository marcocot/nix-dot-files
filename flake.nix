{
  description = "NixOS configuration and home-manager configurations";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    agenix.url = "github:ryantm/agenix";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, home-manager, nix-darwin, nixpkgs, agenix, ... } @ inputs:
    let
      nixpkgsConfig = {
        config = { allowUnfree = true; };
      };
    in
    {
      nix.settings.experimental-features = "nix-command flakes";

      darwinConfigurations = {
        "Marcos-MacBook-Pro" = nix-darwin.lib.darwinSystem rec {
          system = "x86_64-darwin";
          modules = [
            ./modules/darwin.nix
            ./host/macbook
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;

              # `home-manager` config
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.marco = import ./home;
            }
          ];
        };
      };

      # Desktop Configuration
      nixosConfigurations = {
        balder = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit inputs; };
          modules = [
            ./host/balder
            home-manager.nixosModules.home-manager
            {
              nixpkgs = nixpkgsConfig;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.marco = import ./home;
            }
          ];
        };

        heimdall = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
        
          specialArgs = { inherit inputs; };
          modules = [
            agenix.nixosModules.default
            ./host/heimdall
           
            home-manager.nixosModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.marco = import ./home;
            }
          ];
      };
    };
  };
}
