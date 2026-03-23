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
      thunderbird = {
        enable = true;
        settings = id: {
          "calendar.registry.deuxfleurs-caldav.uri" = "http://sogo.deuxfleurs.fr/SOGo/dav/fabienheureux/Calendar/personal/";
          "calendar.registry.deuxfleurs-caldav.username" = "fabienheureux@deuxfleurs.fr";
          "calendar.registry.deuxfleurs-caldav.type" = "caldav";
          "calendar.registry.deuxfleurs-caldav.name" = "Deuxfleurs";
        };
      };
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
      thunderbird = {
        enable = true;
        settings = id: {
          "calendar.registry.beta-gouv-caldav.uri" = "https://webmail.beta.gouv.fr/dav/principals/users/951/";
          "calendar.registry.beta-gouv-caldav.username" = "fabien.le.frapper@ext.beta.gouv.fr";
          "calendar.registry.beta-gouv-caldav.type" = "caldav";
          "calendar.registry.beta-gouv-caldav.name" = "Beta Gouv";
        };
      };
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
