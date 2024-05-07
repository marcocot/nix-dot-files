{ pkgs, withGui, ... }:
{
  home = {
    packages = pkgs.lib.optionals withGui [
      pkgs.unstable.davinci-resolve
    ];
  };
}
