{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  security.sudo.wheelNeedsPassword = false;

  console = {
    useXkbConfig = true;
  };

  services.xserver = {
    enable = true;
    autorun = true;
    libinput.enable = true;

    xkb = {
      layout = "gb";
      variant = "colemak";
      options = "lv3:ralt_alt,terminate:ctrl_alt_bksp";
    };

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
    };
  };

  users.users.ryan = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9qkCB4kpyspseIOpk0BG/6Ojk3KMQr3qOOUPFxlY2Q"
    ];
  };

  environment.systemPackages = with pkgs; [ ];

  services.openssh = {
    enable = true;
    settings = {
      KexAlgorithms = [ "curve25519-sha256" ];
      Ciphers = [ "aes256-gcm@openssh.com" ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    iosevka
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
