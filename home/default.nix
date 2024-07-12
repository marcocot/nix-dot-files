{ pkgs, lib, specialArgs, ... }:
let
  inherit (specialArgs) withGui;
in
{
  imports = [
    ./shell.nix
    ./editors.nix
    ./git.nix
    ./mail.nix
  ];

  config = with lib; {
    home.packages = with pkgs;
      [
        unstable.devenv
        (fenix.stable.withComponents [
          "cargo"
          "clippy"
          "rust-src"
          "rustc"
          "rustfmt"
        ])
        rust-analyzer

      ] ++ lib.optionals withGui [
        # on darwin those are managed with homebrew
        spotify
        thunderbird
      ];

    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
  };
}
