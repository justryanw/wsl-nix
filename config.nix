{ ... }: {
  imports = [ ./wsl-vpn.nix ];

  wsl-vpn.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
}
