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
          repo = "template";
          rev = "5aedbc8d992fc625b316d58d3d775852c2d23172";
          sha256 = "sha256-myC0fYy0+EF3Ah06Fvg2m4l3INTQxaCiKN3xpNugIyU=";
        };
      };

      ".config/nvim/lua/plugins/custom.lua" = {
        text = ''
          return {
             "AstroNvim/astrocommunity",
              { import = "astrocommunity.pack.typescript"},
              { import = "astrocommunity.pack.rust"},
              { import = "astrocommunity.pack.tailwindcss"},
              { import = "astrocommunity.pack.python-ruff"},
              { import = "astrocommunity.pack.php"},
              { import = "astrocommunity.code-runner.compiler-nvim"},
              { import = "astrocommunity.pack.nix"},
              { import = "astrocommunity.pack.cpp"},
              { import = "astrocommunity.code-runner.compiler-nvim"}
          }
        '';
      };

      ".config/nvim/lua/plugins/surround.lua" = {
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

      ".config/nvim/lua/plugins/wakatime.lua" = {
        text = ''
          return {
            "wakatime/vim-wakatime",
            lazy = false
          }
        '';
      };
      ".config/nvim/lua/user/lsp/config/clangd.lua" = {
        text = ''
          return {
            capabilities = {
             offsetEncoding = "utf-8",
            },
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
