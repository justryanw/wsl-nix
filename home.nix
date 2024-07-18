{ user, ... }: {
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.05";
  };

  programs = {
    zsh = {
      enable = true;
      history.size = 1000;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        la = "ls -A";
        sys = "sudo systemctl";
        usr = "systemctl --user";
      };
    };

    starship.enable = true;

    git = {
      enable = true;
      userName = "Ryan Walker";
      userEmail = "ryan.walker@inseinc.com";
      extraConfig.pull.rebase = false;
      aliases.acm = "!git add -A && git commit -m";
    };

    ssh = {
      enable = true;
      matchBlocks = {
        bitbucket = {
          hostname = "bitbucket.ingg.com";
          port = 7999;
        };
      };
    };
  };
}
