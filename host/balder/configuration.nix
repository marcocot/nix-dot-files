{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      efiSysMountPoint = "/boot/efi";
      canTouchEfiVariables = true;
    };
  };

  networking.hostName = "balder"; # Define your hostname.

  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "it";
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  services = {
    printing.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };


    xserver = {
      videoDrivers = [ "nvidia" ];
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = false;
        };

        # defaultSession = "plasmawayland";
      };
      desktopManager = {
        plasma5.enable = true;
      };
      xkb.layout = "it";
    };

  };

  environment.systemPackages = with pkgs; [
    unzip
  ];

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.marco = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };

  programs.zsh.enable = true;
  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";
}
