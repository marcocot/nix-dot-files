{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    userEmail = "marco.cotrufo@devncode.it";
    userName = "Marco Cotrufo";

    ignores = [ ".DS_Store" ];

    extraConfig = {
      core = {
        autocrlf = "input";
      };
      color = {
        ui = "auto";
      };
      push = {
        default = "current";
        autoSetupRemote = "true";
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autostash = true;
      };
      commit = {
        verbose = true;
      };
      rerere = {
        enabled = true;
      };
    };
  };
}
