{
  description = "NixOS configuration and home-manager configurations";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
  outputs = { home-manager, nix-darwin, nixpkgs, nixpkgs-unstable, agenix, ... } @ inputs:
    let
      nixpkgsConfig = {
        config = { allowUnfree = true; };
      };

      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    in
    {
      nix.settings.experimental-features = "nix-command flakes";
      nixpkgs.overlays = [ overlay-unstable ];

      darwinConfigurations = {
        "Marcos-MacBook-Pro" = nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })

            ./modules/darwin.nix
            ./host/macbook
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  withGui = false;
                };
                users.marco = import ./home;
              };
            }
          ];
        };
      };

      # Desktop Configuration
      nixosConfigurations = {
        heimdall = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit inputs; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })

            agenix.nixosModules.default
            ./host/heimdall

            home-manager.nixosModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  withGui = false;
                };
                users.marco = import ./home;
              };
            }
          ];
        };
      };

      homeConfigurations = {
        "marco" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;

          extraSpecialArgs = {
            withGui = true;
          };
          modules = [
            ./home
            {
              targets.genericLinux.enable = true;
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [ overlay-unstable ];
              home = {
                username = "marco";
                homeDirectory = "/home/marco";
                stateVersion = "23.11";
              };
            }
          ];

        };
      };
    };
}
