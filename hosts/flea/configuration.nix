{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  system.stateVersion = "23.11";
}
