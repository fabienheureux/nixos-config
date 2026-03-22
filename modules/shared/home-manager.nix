{ config, pkgs, lib, ... }:

let name = "Fabien Le Frapper";
    user = "fabienlefrapper";
    email = "contact@fabienlefrapper.me"; in
{
  # Shared shell configuration
  fish = {
    enable = true;
    interactiveShellInit = ''
      # Nix
      if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      end

      # PATH additions
      fish_add_path $HOME/.local/bin
      fish_add_path $HOME/.local/share/bin

      # OrbStack integration
      source ~/.orbstack/shell/init2.fish 2>/dev/null || true

      # Scaleway CLI autocomplete
      eval (scw autocomplete script shell=fish)

      # Editor
      set -gx EDITOR hx
      set -gx VISUAL hx
      set -gx ALTERNATE_EDITOR ""

      # Aliases
      alias search="rg -p --glob '!node_modules/*'"
      alias diff="difft"
      alias ls="ls --color=auto"
      alias pn="pnpm"
      alias px="pnpx"

      # nix shell helper
      function shell
        nix-shell '<nixpkgs>' -A $argv
      end
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    lfs = {
      enable = true;
    };
    settings = {
      user.name = name;
      user.email = email;
      init.defaultBranch = "main";
      core = {
        editor = "hx";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "*" = {
        # Set the default values we want to keep
        sendEnv = [ "LANG" "LC_*" ];
        hashKnownHosts = true;
      };
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
      "git.deuxfleurs.fr" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_deuxfleurs"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_deuxfleurs"
          )
        ];
      };
    };
  };
}
