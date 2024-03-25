{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    jetbrains.phpstorm
    vscode
    nixpkgs-fmt
    direnv
    lazygit
    ripgrep
    tree-sitter

    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" "Hack" ]; })
  ];

  home.file.".config/nvim" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "AstroNvim";
      repo = "AstroNvim";
      rev = "2fcb9e20c13aaa3653421017236ec076db3a4c00";
      sha256 = "sha256-dgKjLA+Ovq0bjdTBvwf03cyELS1h0Mb2CeHXT4Uu1DM=";
    };
  };

  home.file.".config/nvim/lua/user/init.lua" = {
    text = ''
      return {
        plugins = {
          telescope = {
            defaults = {
              file_ignore_patterns = {
                "^node_modules/"
              },
            },
          },
          "AstroNvim/astrocommunity",
          { import = "astrocommunity.pack.typescript"},    { import = "astrocommunity.pack.rust"},
          { import = "astrocommunity.pack.tailwindcss"},
          { import = "astrocommunity.pack.python-ruff"},
          { import = "astrocommunity.pack.php"},
          { import = "astrocommunity.code-runner.compiler-nvim"},
        }
      }
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
