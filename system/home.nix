{ config, pkgs, ... }:

{
###
# System
###
  home.stateVersion = "23.05";
  home.username = "erin";
  home.homeDirectory = "/home/erin";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    # foo.nix
  ];

  home.sessionVariables = {
    EDITOR = "code";
  };

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    # Allow git code signing with SSH key
    ".ssh/allowed_signers".text ="* ${builtins.readFile /home/erin/.ssh/id_git.pub}";
  };

###
# Packages
###
  nixpkgs.config.allowUnfree = true;
  
#  nix = {
#    package = pkgs.nix;
#    settings.experimental-features = [ "nix-command" "flakes" ];
#  };
  
# Blog to read: https://dev.jmgilman.com/environment/tools/direnv/
  programs.direnv = {
    enable = true;
      nix-direnv = {
        enable = true;
      };
  };

  home.packages = with pkgs; [
    firefox
    gimp
    obs-studio
    skypeforlinux
    spotify
    sshfs
    stellarium
    vim
    vscode
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="/home/erin/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$PATH"
      #export XDG_DATA_DIRS="/home/erin/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$XDG_DATA_DIRS"
    '';
    };

  programs = {
    git = {
      enable = true;
      userName = "Erin McNamara";
      userEmail = "152170105+ivyemcn@users.noreply.github.com";

      extraConfig = {
        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        user.signingkey = "~/.ssh/id_git.pub";
      };
    };
  };
}
