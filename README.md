### Build WSL system tarball
```bash
sudo nix run .#nixosConfigurations.nixos.config.system.build.tarballBuilder
```
### Update existing system
```bash
sudo nixos-rebuild switch --refresh --flake github:justryanw/wsl-nix
```