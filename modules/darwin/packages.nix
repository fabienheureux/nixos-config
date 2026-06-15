{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # D
  dockutil # Manage icons in the dock

  # F
  firefox-devedition
  fswatch # File change monitor

  # Communication
  discord
  slack
  telegram-desktop
  thunderbird

  # Productivity
  bitwarden-desktop
  obsidian
  raycast

  # Browsers
  google-chrome

  # Dev tools
  insomnia
  ngrok
  orbstack

  # Sync
  syncthing
]
