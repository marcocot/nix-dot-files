{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    pass

    # extra packages
    spotify
    vlc
    slack
    brave
    transmission-qt
    thunderbird

    # development
    nodejs_20
    yarn
    python3
    poetry
    php83
    php83Packages.composer
    docker-compose
  ];


  imports = [
    ./shell.nix
    ./editors.nix
    ./git.nix
    ./mail.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
