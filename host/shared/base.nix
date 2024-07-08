{ inputs, ... }:
{
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  boot.loader.systemd-boot.configurationLimit = 5;

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure console keymap
  console = {
    font = "Lat2-Terminus16";
    keyMap = "it";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
