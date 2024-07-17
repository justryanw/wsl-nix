{ ... }: {
  imports = [ ./wsl-vpn.nix ];

  wsl-vpn.enable = true;
}