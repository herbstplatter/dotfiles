{ config, pkgs, ... }:

{
  home.username = "luft";
  home.homeDirectory = "/home/luft";

  # dotfiles
  home.file = {
    ".config/qtile/config.py".source = ./dots/qtile/config.py;
  };
  
  
  # You should not change this value, even if you update Home Manager.
  # if you do; read the release note first
  home.stateVersion = "24.11"; # Must be the same stateVersion in your configuration.nix

  programs.home-manager.enable = true;
}

