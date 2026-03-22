{ config, pkgs, lib, home-manager, ... }:

let
  user = "fabienlefrapper";
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.shells = [ pkgs.fish ];

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    # onActivation.cleanup = "uninstall";

    masApps = {
      # "wireguard" = 1451685025;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
          {
            ".config/ghostty/config".text = ''
              font-family = FiraCode Nerd Font Retina
              theme = Gruvbox Light
              keybind = shift+enter=text:\x1b\r
            '';

            ".config/helix/config.toml".text = ''
              theme = "gruvbox_light"

              [editor]
              mouse = false

              [editor.file-picker]
              hidden = false
            '';

            ".config/helix/languages.toml".text = ''
              [[language]]
              name = "html"
              language-servers = [ "tailwindcss-ls", "vscode-html-language-server", "djlsp" ]
              auto-format = false
              formatter = { command = "djade", args = [] }

              [language-server.djlsp]
              command = "uvx"
              args = ["djlsp"]

              [[language]]
              name = "css"
              language-servers = [ "vscode-css-language-server", "tailwindcss-ls" ]
              formatter = { command = "npx", args = ["prettier", "--parser", "css"] }

              [[language]]
              name = "javascript"
              formatter = { command = "npx", args = ["prettier"] }

              [[language]]
              name = "typescript"
              language-servers = [ { name = "efm-lsp-prettier", only-features = [ "format" ] }, "typescript-language-server", "vscode-eslint-language-server" ]
              formatter = { command = "npx", args = ["prettier", "--parser", "typescript"] }

              [[language]]
              name = "python"
              roots = ["pyproject.toml", ".git", ".venv/", "poetry.lock"]
              language-servers = ["pyright", "ruff"]
              formatter = { command = "ruff", args = ["format", "-"]}

              [[language]]
              name = "rust"
              language-servers = [ "rust-analyzer" ]
              formatter = { command = "rustfmt" }

              [language-server.pyright]
              command = "uvx"
              args = ["--from", "pyright", "pyright-langserver", "--stdio"]

              [language-server.ruff]
              command = "uvx"
              args = ["ruff", "server"]
              environment = { "RUFF_TRACE" = "messages" }

              [language-server.efm-lsp-prettier]
              command = "efm-langserver"

              [language-server.tailwindcss-ls]
              command = "tailwindcss-language-server"
              args = ["--stdio"]
              config = { userLanguages = { html = "html", css = "css", javascript = "javascript", typescript = "typescript" } }
            '';
          }
        ];

        stateVersion = "23.11";
      };
      programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };

      accounts.email.accounts = {
        "deuxfleurs" = {
          primary = true;
          address = "contact@fabienlefrapper.me";
          realName = "Fabien Le Frapper";
          userName = "contact@fabienlefrapper.me";
          imap = {
            host = "imap.deuxfleurs.fr";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "smtp.deuxfleurs.fr";
            port = 465;
            tls.enable = true;
          };
          thunderbird.enable = true;
        };
        "beta-gouv" = {
          address = "fabien.le.frapper@ext.beta.gouv.fr";
          realName = "Fabien Le Frapper";
          userName = "fabien.le.frapper@ext.beta.gouv.fr";
          imap = {
            host = "imap.ext.beta.gouv.fr";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "smtp.ext.beta.gouv.fr";
            port = 465;
            tls.enable = true;
          };
          thunderbird.enable = true;
        };
      };

      programs.thunderbird = {
        enable = true;
        package = pkgs.thunderbird;
        profiles.default = {
          isDefault = true;
        };
      };

      home.file."notes/.obsidian/core-plugins.json".text = builtins.toJSON {
        "file-explorer" = true;
        "global-search" = true;
        "switcher" = true;
        "graph" = true;
        "backlink" = true;
        "canvas" = true;
        "outgoing-link" = true;
        "tag-pane" = true;
        "footnotes" = false;
        "properties" = true;
        "page-preview" = true;
        "daily-notes" = true;
        "templates" = true;
        "note-composer" = true;
        "command-palette" = true;
        "slash-command" = false;
        "editor-status" = true;
        "bookmarks" = true;
        "markdown-importer" = false;
        "zk-prefixer" = false;
        "random-note" = false;
        "outline" = true;
        "word-count" = true;
        "slides" = false;
        "audio-recorder" = false;
        "workspaces" = false;
        "file-recovery" = true;
        "publish" = false;
        "sync" = false;
        "bases" = true;
        "webviewer" = false;
      };

      home.file."notes/.obsidian/daily-notes.json".text = builtins.toJSON {
        folder = "Journal";
      };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = {
    dock = {
      enable = true;
      username = user;
      entries = [
        { path = "/Applications/Ghostty.app/"; }
        { path = "/Applications/Firefox Developer Edition.app/"; }
        { path = "/System/Applications/Messages.app/"; }
        { path = "/System/Applications/Notes.app/"; }
        { path = "/System/Applications/Music.app/"; }
        { path = "/System/Applications/System Settings.app/"; }
        {
          path = "${config.users.users.${user}.home}/Downloads";
          section = "others";
          options = "--sort name --view grid --display stack";
        }
      ];
    };
  };
}
