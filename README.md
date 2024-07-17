### Build WSL image
```bash
sudo nix run .#nixosConfigurations.nixos.config.system.build.tarballBuilder
```
### Update existing image
```bash
sudo nixos-rebuild switch --refresh --flake github:justryanw/wsl-nix
```