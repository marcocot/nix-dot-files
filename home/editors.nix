{ pkgs, withGui, ... }:
{
  home = {
    packages = with pkgs; [
      neovim
      direnv
      lazygit
      ripgrep
      tree-sitter

      # For nix development
      alejandra
      deadnix
      statix
      nixpkgs-fmt
      nil

      (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" "Hack" ]; })

    ] ++ lib.optionals withGui [
      unstable.jetbrains.phpstorm
      unstable.vscode
      unstable.android-studio
      unstable.scrcpy
      unstable.android-tools
    ];

    file = {
      ".config/nvim" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "AstroNvim";
          repo = "AstroNvim";
          rev = "2fcb9e20c13aaa3653421017236ec076db3a4c00";
          sha256 = "sha256-dgKjLA+Ovq0bjdTBvwf03cyELS1h0Mb2CeHXT4Uu1DM=";
        };
      };

      ".config/nvim/lua/user/init.lua" = {
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
              { import = "astrocommunity.pack.typescript"},
              { import = "astrocommunity.pack.rust"},
              { import = "astrocommunity.pack.tailwindcss"},
              { import = "astrocommunity.pack.python-ruff"},
              { import = "astrocommunity.pack.php"},
              { import = "astrocommunity.code-runner.compiler-nvim"},
              { import = "astrocommunity.pack.nix"}
            }
          }
        '';
      };

      ".config/nvim/lua/user/plugins/surround.lua" = {
        text = ''
          return {
            "kylechui/nvim-surround",
            event = "VeryLazy",
            config = function() 
              require("nvim-surround").setup({})
            end
          }
      '';
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  fonts.fontconfig.enable = true;
}
