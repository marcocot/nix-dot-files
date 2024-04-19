{ pkgs, withGui, ... }:
{
  home = {
    packages = with pkgs; [
    ] ++ lib.optionals withGui [
      unstable.davinci-resolve
    ];
  };
}
