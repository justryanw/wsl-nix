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

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  programs = {
    zsh.enable = true;
    nh.enable = true;

    # https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
  };

  services.openssh = {
    enable = true;
    ports = [ 2224 ];
  };

  users.users.${user} = {
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2+1HkbVk10Wt5I5l6iPkXcAUCLQ8EQ4qs9MYIXXlqK ryan@Desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDGUsv2xnB04Jh+M15As1jJs/MvtnAqeJ5FsSaXGv3S ryanjwalker2001@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/tpdZr5X8NgBldgtviMMgNOUWDRckjZNYIhIk/CX/h ryan@Laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWIiPRXGHVkhx1O/YDNOJfFQADhld2CxQKRKCnW1Fhv ryan@NixVM"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbOCsQ0JHfnFgOanl56w/y1o3dhHtOnkgqW8aTBxWuc ryan.walker@LAP00396"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs user; };
    users.${user} = import ./home.nix;
  };

  wsl-vpn.enable = true;

  environment = {
    pathsToLink = [ "/share/zsh" ];
    
    systemPackages = with pkgs; [
      nixd
      nixpkgs-fmt
    ];
  };
}
