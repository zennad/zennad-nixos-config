{ config, pkgs, ... }:

{
  nix.settings = {
    trusted-users = [ "root" "@wheel" ];
    allowed-users = [ "root" "@wheel" ];
  };

  boot.loader = {
    systemd-boot = {
      # Use the systemd-boot EFI boot loader.
      enable = true;
      editor = false;
    };
    efi.canTouchEfiVariables = true;
  };

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

        main = do d <- getDirectories
                  launch defaultConfig
                    { modMask = mod4Mask -- Use Super instead of Alt
                    , terminal = "alacritty"
                    }
                    d
        '';
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    w3m
    networkmanager
    gnupg
    alacritty
    dmenu
    gmrun
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

