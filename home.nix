{ config, pkgs, ... }:

{
  home.username = "tubowen";
  home.homeDirectory = "/Users/tubowen";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    neovim
    nodejs
    python3
    ripgrep
    fd
    htop
    tmux
  ];
 
  xdg.configFile."nvim".source = ./nvim;

  xdg.configFile."kitty".source = ./kitty;
}

