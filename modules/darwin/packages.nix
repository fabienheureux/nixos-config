{ pkgs, lib }:

with pkgs;
let
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
  # zed-editor has no aarch64-darwin cache on Hydra and builds from source;
  # installed via Homebrew cask (casks.nix) instead
  darwin-shared-packages = lib.filter (p: p != zed-editor) shared-packages;
in
darwin-shared-packages ++ [
  # D
  dockutil # Manage icons in the dock

  # F
  firefox-devedition
  fswatch # File change monitor

  # Communication
  discord
  element-desktop
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
  opencode
  orbstack

  # Sync
  syncthing

  # VPN
  wireguard-tools # wg, wg-quick client

  # Audio
  vcv-rack
]
