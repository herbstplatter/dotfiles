{ config, pkgs, ... }:

{
  imports = [
   ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.luft = {
    isNormalUser = true;
    home = "/home/luft";
    description = "luft means air";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [    
    # Utilities
    tk
    fish
    wl-clipboard
    fastfetch
    pulseaudio
    brightnessctl
    wlr-randr

    # Applications
    firefox
    kitty
    dmenu-wayland
    neovim
    heroic
    gimp
    fsearch
    font-manager
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
    nerd-fonts.jetbrains-mono
    terminus_font
    gohufont
    siji
  ];

  
  # Git
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "herbstplatter";
      };
    };
  };

  # Display services
  services.displayManager.ly.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  security.polkit.enable = true;

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
  };
  services.resolved = {
    enable = true;
    dnssec = "true";
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
    extraConfig = '' DNSOverTLS=opportunistic '';
  };
  networking.nameservers = [ "127.0.0.53" ];

  # Locale
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8"; 

  # Enable printing with CUPS
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";

}
