{ ... }: {
  imports = [ ./wsl-vpn.nix ];

  wsl-vpn.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}