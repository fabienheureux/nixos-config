{ config, pkgs, lib, ... }:

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
}
