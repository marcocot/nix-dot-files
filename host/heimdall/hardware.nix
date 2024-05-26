# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = with config.boot.kernelPackages; [
      rtl8821cu
    ];
    blacklistedKernelModules = ["rtl8xxxu"];

  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/a220fca1-b4f0-4626-bbdc-9bc489f8a1de";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/E723-B8CC";
      fsType = "vfat";
    };

    "/mnt/media" = {
      device = "/dev/sdb1";
      fsType = "ext4";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/e24bd846-04a2-4597-bc39-48b45cb71b7d"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking = {
    interfaces.eno1 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.178.172";
        prefixLength = 24;
      }];
    };

    defaultGateway = "192.168.178.254";
    nameservers = [ "8.8.8.8" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
