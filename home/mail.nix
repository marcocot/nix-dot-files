{ pkgs, ... }:
{
  programs.thunderbird = with pkgs; {
    enable = stdenv.isLinux;
    profiles = {
      marco = {
        isDefault = true;
        settings = {
          "calendar.registry.8cb74868-e955-49ba-a864-0bc5063821ef.type" = "caldav";
          "calendar.registry.8cb74868-e955-49ba-a864-0bc5063821ef.uri" = "https://calendar.zoho.eu/caldav/zz080112302e8a4359176f396d2394d1bb1c4e5e9d209e19c2fe4c518b96e747ff131be5dac65d21e6621c56071e84d709277e892d/events/";
          "calendar.registry.8cb74868-e955-49ba-a864-0bc5063821ef.name" = "My Calendar";
        };
      };
    };
  };

  accounts.email = with pkgs; {
    accounts.runbox = {
      address = "marco.cotrufo@runbox.it";
      imap.host = "mail.runbox.com";
      imap.port = 993;
      userName = "marco.cotrufo@runbox.it";
      primary = true;
      realName = "Marco Cotrufo";
      smtp = {
        host = "mail.runbox.com";
        port = 465;
      };

      thunderbird = {
        enable = stdenv.isLinux;
      };
    };
  };
}
