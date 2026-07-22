{ config, pkgs, lib, secrets, ... }:

let
  name = "Fabien Le Frapper";
  user = "fabienlefrapper";
  email = "contact@fabienlefrapper.me";
in
{
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings =
        # Load calendar settings from the private secrets repo
        import "${secrets}/thunderbird-calendars.nix";
    };
  };

  accounts.email.accounts = {
    "deuxfleurs" = {
      primary = true;
      address = email;
      realName = name;
      userName = email;
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
      realName = name;
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

  home.file."notes/.obsidian/core-plugins.json".text = ''
    ${builtins.toJSON {
      "audio-recorder" = false;
      "backlink" = true;
      "bases" = true;
      "bookmarks" = true;
      "canvas" = true;
      "command-palette" = true;
      "daily-notes" = true;
      "editor-status" = true;
      "file-explorer" = true;
      "file-recovery" = true;
      "footnotes" = false;
      "global-search" = true;
      "graph" = true;
      "markdown-importer" = false;
      "note-composer" = true;
      "outgoing-link" = true;
      "outline" = true;
      "page-preview" = true;
      "properties" = true;
      "publish" = false;
      "random-note" = false;
      "slash-command" = false;
      "slides" = false;
      "switcher" = true;
      "sync" = false;
      "tag-pane" = true;
      "templates" = false;
      "webviewer" = false;
      "word-count" = true;
      "workspaces" = false;
      "zk-prefixer" = false;
    }}
  '';

  home.file."notes/.obsidian/daily-notes.json".text = ''
    ${builtins.toJSON {
      folder = "01-Fleeting";
      template = "99-Templates/travail-daily.md";
      format = "YYYYMMDD-travail-daily";
      autorun = false;
    }}
  '';
}
