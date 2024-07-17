### Build WSL image
```bash
sudo nix run .#nixosConfigurations.nixos.config.system.build.tarballBuilder
```