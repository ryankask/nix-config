{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "sloth";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # QEMU
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  console = {
    useXkbConfig = true;
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "gb";
      variant = "colemak";
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
    autorun = true;
    libinput.enable = true;
  };

  users.users.ryan = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9qkCB4kpyspseIOpk0BG/6Ojk3KMQr3qOOUPFxlY2Q"
    ];
  };

  environment.systemPackages = with pkgs; [
    bottom
    curl
    emacs
    git
    iosevka
    kitty
    tree
    wget
  ];

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

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
