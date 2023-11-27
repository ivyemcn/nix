# NixOS

🎉 Managing a NixOS and Windows 10 dual booted workflow

Windows 10 was using the full disk, performed a dual boot install by using the NixOS Gnome installer. Used the automatic options for dual partitions and let it go. 

The base system is very minimal with

```nix
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.cinnamon.apps.enable = false; 
```

<details>
  <summary>configuartion.nix for the system</summary> 

```nix
{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./networking.nix
    ];

###
# System
###
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  
  system.stateVersion = "23.05";

  time.timeZone = "America/Edmonton";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

###
# Desktop
###
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.cinnamon.apps.enable = false; 

###
# System Services
###

  services.tailscale.enable = true;

  # Flatpak
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      X11Forwarding = true;
      PasswordAuthentication = false;
    };
  };

  services.printing = {
    enable = true;
    drivers = [
      #pkgs.gutenprint
      #pkgs.cups-bjnp
      #pkgs.hplip
      #pkgs.cnijfilter2
    ];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

###
# Users
###
  users.users = {
    sol = {
      isNormalUser = true;
      description = "sol";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        firefox
      ];
    };
    erin = {
      isNormalUser = true;
      description = "erin";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };
  };

###
# Packages
###
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    bitwarden
    cifs-utils
    dislocker
    docker-compose
    exfat
    gnumake
    gparted
    ifuse
    libimobiledevice
    libwebp
    ntfs3g
    parted
    pciutils
    unzip
    usbutils
    vim
    webp-pixbuf-loader
    xorg.xauth
    zfstools
    zip
  ];

}

```
</details>


## Home Manager

Is managed at the user level leaving very little for the base system to manage. Under the `system` folder houses a basic home setup for my user.