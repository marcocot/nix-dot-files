{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh
  ];

  home.file = {
    ".p10k.zsh" = {
      source = ./p10k.zsh;
      recursive = true;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "direnv" "git" "z" "brew" "asdf" ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initExtra = ''
      source ~/.p10k.zsh
    '';

  };
}
