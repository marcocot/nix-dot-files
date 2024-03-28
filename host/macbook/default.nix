{ nixpkgs, nix-darwing, ... }: {
  programs.zsh.enable = true;

  users = {
    users = {
      marco = {
        shell = nixpkgs.zsh;
        home = "/Users/marco";
      };
    };
  };

  homebrew = {
    enable = true;
    brews = [
      "aria2"
      "awscli"
      "symfony-cli"
      "tailscale"
      "wget"
    ];

    casks = [
      "brave-browser"
      "cyberduck"
      "dbeaver-community"
      "firefox"
      "iterm2"
      "orbstack"
      "phpstorm"
      "plex"
      "slack"
      "spotify"
      "stremio"
      "transmission"
      "visual-studio-code"
      "vlc"
    ];
  };

  homebrew.onActivation.cleanup = "zap";
  homebrew.taps = [
    "homebrew/cask-fonts"
    "symfony-cli/tap"
  ];

  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      ShowPathbar = true;
    };
  };
}
