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
        gcc
        gnumake
        pass

        # development
        act
        nodejs_20
        yarn
        python3
        poetry
        php83
        php83Packages.composer
      ] ++ lib.optionals withGui [
        # on darwin those are managed with homebrew
        spotify
        vlc
        slack
        brave
        transmission-qt
        thunderbird
      ];

    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
  };
}
