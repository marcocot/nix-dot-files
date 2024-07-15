# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "heimdall"; # Define your hostname.
    networkmanager.enable = false;

    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 22 80 443 6443 ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      trustedInterfaces = [ "tailscale0" ];
      extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
    };
  };

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  users.users.marco = {
    isNormalUser = true;
    description = "Marco Cotrufo";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    git

    # to enable ansible
    (pkgs.python311.withPackages (ps: [ ps.requests ]))

    # backups
    restic

    # enable tailscale login
    tailscale
  ];

  services = {
    openssh.enable = true;
    avahi = {
      enable = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    plex = with pkgs; {
      enable = true;
      openFirewall = true;
      user = "marco";
      group = "users";
      package = unstable.plex;
    };
    restic.backups = {
      daily = {
        initialize = true;
        environmentFile = config.age.secrets."restic/env".path;
        repositoryFile = config.age.secrets."restic/repo".path;
        passwordFile = config.age.secrets."restic/password".path;

        paths = [
          "/mnt/media/config"
        ];

        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
        ];
      };
    };

    samba-wsdd = { enable = true; openFirewall = true; };
    samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;
      shares = {
        library = {
          path = "/mnt/media/library/";
          browseable = "yes";
          "valid users" = "marco";
          "read only" = "no";
          "guest ok" = "no";
        };
        downloads = {
          path = "/mnt/media/downloads";
          browseable = "yes";
          "valid users" = "marco";
          "read only" = "no";
          "guest ok" = "no";
        };
        timemachine = {
          path = "/mnt/media/timemachine";
          "valid users" = "marco";
          public = "no";
          writeable = "yes";
          "force user" = "marco";
          "fruit:aapl" = "yes";
          "fruit:time machine" = "yes";
          "fruit:model" = "N88AP";
          "vfs objects" = "catia fruit streams_xattr";
        };
      };
    };

    tailscale = {
      enable = true;
    };
  };

  virtualisation.docker.enable = true;
  age = {
    identityPaths = [ "${config.users.users.marco.home}/.ssh/id_ed25519" ];
    secrets = {
      "restic/env".file = ../../secrets/restic/env.age;
      "restic/repo".file = ../../secrets/restic/repo.age;
      "restic/password".file = ../../secrets/restic/password.age;
    };
  };


  system.stateVersion = "23.11";
}
