{ pkgs }:

with pkgs; [
  # General packages for development and system management
  bash-completion
  bat
  btop
  coreutils
  killall
  openssh
  sqlite
  wget
  zip

  # Encryption and security tools
  age
  age-plugin-yubikey
  bitwarden-cli
  gnupg
  libfido2
  sops

  # Cloud-related tools and SDKs
  opentofu
  terragrunt
  scaleway-cli
  scalingo

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-color-emoji
  meslo-lgs-nf
  nerd-fonts.fira-code

  # Node.js development tools
  nodejs_24

  # Text and terminal utilities
  htop
  jetbrains-mono
  jq
  ripgrep
  tree
  unrar
  unzip

  # Development tools
  curl
  gh
  lazygit
  fzf
  direnv
  rustup
  go

  # Shell and prompt
  fish

  # Editor
  helix
  zed-editor

  # Task runner and version manager
  just
  mise

  # Diff and search
  difftastic

  # Database clients
  gdal
  geos
  postgresql

  # Python packages
  python3
  virtualenv

  # Helix LSP servers and tools
  vscode-langservers-extracted
  typescript-language-server
  tailwindcss-language-server
  efm-langserver
  uv
  ruff
  prettierd
]
