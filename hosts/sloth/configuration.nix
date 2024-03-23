{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sloth";

  # QEMU
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  system.stateVersion = "24.05";
}
