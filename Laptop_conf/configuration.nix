{ config, pkgs, ... }:


let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
in

{
  imports =
    [ # Include the results of the hardware scan.
      (import "${home-manager}/nixos")
      ./hardware-configuration.nix
      ./poweroptimizaion.nix
      #./kde.nix
      ./i3.nix
      ./systemManagement.nix
    ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Fprint Service
  services.fprintd.enable = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.


  home-manager = {
    useUserPackages = true;
    users.niklas = { pkgs, ... }: {
      home.packages = [
	    
      ];
      home.stateVersion = "26.05";
    };
  };

    
users.users."niklas" = {
    isNormalUser = true;
    description = "niklas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      pkgs.heroic
      pkgs.obsidian
      pkgs.libreoffice
#      pkgs.steam
      pkgs.gimp     
      kdePackages.dolphin
      kdePackages.kcalc
      kdePackages.kate

      
      #Dev Tools
      pkgs.texliveFull
      pkgs.vscode-fhs
      pkgs.python3
      pkgs.maven
      pkgs.git
      
      #Shell
      pkgs.kitty
      pkgs.fastfetch
      pkgs.htop
    ];
  };
  programs.java.enable = true;
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
     vim
     brightnessctl
     pkgs.home-manager
     pkgs.pavucontrol
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
