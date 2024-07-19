{ pkgs, ... } @ inputs:
let
  # Don't change user without folling thse steps https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
  # Use this rebuild command: nh os boot github:justryanw/wsl-nix/ryan
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

  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 2224 ];
  };

  users.users.${user} = {
    shell = pkgs.zsh;
    authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbOCsQ0JHfnFgOanl56w/y1o3dhHtOnkgqW8aTBxWuc inseinc\ryan.walker@LAP00396"
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs user; };
    users.${user} = import ./home.nix;
  };

  wsl-vpn.enable = true;

  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      nh
    ];
  };
}
