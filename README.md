## Quick Start
1. Enable WSL if you haven't done so already:

- ```powershell
  wsl --install --no-distribution
  ```

2. Download `nixos-wsl.tar.gz` from [the latest release](https://github.com/justryanw/wsl-nix/releases/latest).

3. Import the tarball into WSL:

- ```powershell
  wsl --import NixOS $env:USERPROFILE\NixOS\ nixos-wsl.tar.gz
  ```

4. You can now run NixOS:

- ```powershell
  wsl -d NixOS
  ```

## Update existing system
- ```bash
  nh os switch github:justryanw/wsl-nix/ryan
  ```

## Build WSL system tarball
- ```bash
  sudo nix run .#nixosConfigurations.nixos.config.system.build.tarballBuilder
  ```