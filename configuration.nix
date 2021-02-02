# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';
    trustedUsers = [ "root" "@wheel" ];
    allowedUsers = [ "root" "@whell" ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap = {
    enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  networking = {
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp0s25.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;

    hostName = "nixos"; # Define your hostname.

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [ 22 ];

    networkmanager.enable = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver = {
    enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "eurosign:e";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    displayManager.lightdm.enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages:
        with haskellPackages;
          [
            xmonad-contrib
            monad-logger
            pkgs.alacritty
          ];
      config = ''
        import XMonad

        main = launch defaultConfig
                 { modMask = mod4Mask -- Use Super instead of Alt
                 , terminal = "alacritty"
                 }
        '';
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    zennad = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      hashedPassword = 
        "$6$DIcdGUplHK$pceFlXC9JIevO8o4y5.f9A6/r0VnCtcTWFHih1cMBCMbgOoMsirOt6V9IKDk.dtz2IIhCn6xJ1zu4gTJlm178.";
      packages = with pkgs; [
        brave
        alacritty
        dmenu
        bitwarden
        gitFull
      ];
    };
    root.hashedPassword = 
      "$6$Xvo3D2KJfRYf6j$AJ6DqsEOW4OLOlFzPmpR9WUKIqtNBCiEMzCWHt/NANd2MJoJFVeyHOBRu3O15IpfT5c7D4OiyvH00kbSNXcW8/";
  };

  security.sudo.extraConfig =
  ''
    Defaults passwd_timeout = 0
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    w3m
    networkmanager
    gnupg
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

