{ ... } @ inputs:
let
  # Don't change user without folling thse steps https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
  # Use this rebuild command: sudo nixos-rebuild boot --refresh --flake github:justryanw/wsl-nix
  user = "ryan";
in
{
  imports = [
    ./modules/nixos/wsl-vpn.nix
  ];

  system.stateVersion = "24.05";

  wsl = {
    enable = true;
    defaultUser = user;
  };

  nix.settings = {
    trusted-users = [ "root" "@wheel" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  home-manager = {
    extraSpecialArgs = { inherit inputs user; };
    users.nixos = import ./home.nix;
  };

  wsl-vpn.enable = true;
}
