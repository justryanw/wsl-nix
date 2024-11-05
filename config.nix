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

  users.users.${user}.shell = pkgs.zsh;

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
      nix-output-monitor
    ];
  };
}
