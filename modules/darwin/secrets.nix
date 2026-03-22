{ config, pkgs, agenix, secrets, ... }:

let user = "fabienlefrapper"; in
{
  age = {
    identityPaths = [
      "/Users/${user}/.ssh/id_ed25519"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = true;
        path = "/Users/${user}/.ssh/id_github";
        file = "${secrets}/github-ssh-key.age";
        mode = "600";
        owner = "${user}";
        group = "staff";
      };

      "deuxfleurs-ssh-key" = {
        symlink = true;
        path = "/Users/${user}/.ssh/id_deuxfleurs";
        file = "${secrets}/deuxfleurs-ssh-key.age";
        mode = "600";
        owner = "${user}";
        group = "staff";
      };
    };
  };
}
