{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qcal
  ];

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.qcal.enable = true;

  accounts.calendar.basePath = ".calendar";
  accounts.calendar.accounts = {
    devncode = {
      qcal.enable = true;
      remote = {
        url = "https://calendar.zoho.eu/caldav/zz080112302e8a4359176f396d2394d1bb1c4e5e9d209e19c2fe4c518b96e747ff131be5dac65d21e6621c56071e84d709277e892d/events/";
        type = "caldav";
        passwordCommand = [ "pass" "Email/zoho" ];
        userName = "marco.cotrufo@runbox.it";
      };
    };
  };
}
