{ inputs, ... }: {
  imports = [
    ./hardware.nix
    ./configuration.nix
  ];

  environment.etc = {
    issue = {
      text = ''\e[32mWelcome to Heimdall!\e[0m'';
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  system.stateVersion = "23.11";
}
