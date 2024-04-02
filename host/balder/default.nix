{ ... }: {
  imports = [
    ../shared/base.nix
    ./hardware.nix
    ./configuration.nix
  ];

  environment.etc = {
    issue = {
      text = ''\e[32mWelcome to Balder!\e[0m'';
    };
  };

  system.stateVersion = "23.11";
}
