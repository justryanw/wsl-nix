{ ... } @ inputs: {
  imports = [
    ./modules/wsl-vpn.nix
  ];

  system.stateVersion = "24.05";
  wsl.enable = true;

  wsl-vpn.enable = true;

  nix.settings = {
    trusted-users = [ "root" "@wheel" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.nixos = import ./home.nix;
  };
}
