{ nixpkgs, pkgs, ... }: {
  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
  '';

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  environment.systemPackages = with pkgs; [
    asdf-vm
    (pkgs.callPackage ./alfred.nix { })
  ];

  security.pam.enableSudoTouchIdAuth = true;

  nix = {
    settings = {
      trusted-users = [ "root" "marco" ];
    };
  };

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
      "appcleaner"
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

    masApps = {
      "Kindle" = 302584613;
      "Tailscale" = 1475387142;
      "The Unarchiver" = 425424353;
    };
  };

  homebrew.taps = [
    "symfony-cli/tap"
  ];

  system.defaults = {
    dock = {
      mru-spaces = false;
      show-recents = false;
      tilesize = 36;
    };
    finder = {
      _FXShowPosixPathInTitle = true;
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
    };

    menuExtraClock = {
      Show24Hour = true;
      ShowAMPM = true;
      ShowDate = 1;
    };
  };
}
