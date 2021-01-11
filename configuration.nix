# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.kernelModules = [ "zcache" ];

  zramSwap = {
    enable = true;
    # algorithm = "zstd";
  };

  networking = {
    hostName = "nixos-zennad"; # Define your hostname.
    networkmanager.enable = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [ 443 22 ];
    # firewall.allowedUDPPorts = [ ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment =
    {
      systemPackages = with pkgs; [
        wget
        vim
        curl
        networkmanager
        zsh
        zsh-powerlevel10k
        bash
        gnupg
        emacs
        ghc
        stack
        xmonad-with-packages
        zerotierone
      ];
      shells = with pkgs; [ bash zsh ];
    };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  users = with pkgs; {
    defaultUserShell = zsh;
    # mutableUsers = true;
    users.zennad = {
      isNormalUser = true;
      extraGroups = [ "wheel" "sudo" ];
      initialHashedPassword =
        "$6$rXIee8bBDX4inR.R$TOvEJBuhbFeth8n
        49niyehvdvyFxTX3ZnoPYz9vZ4o3Gy7tSgqc
        yfF0q1BsMOBqAlTyNVUkDrw0uvIyrhFUv6.";
      packages = [
        aescrypt
        aespipe
        blender
        coq
        darling-dmg
        firefox
        git-hub
        gnucash
        metamath
        mkpasswd
        neofetch
        neovim
        p7zip
        qemu
        radare2
        unzip
        vlc
        w3m
        wineFull
        winetricks
        wireshark
        runelite
      ];
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
