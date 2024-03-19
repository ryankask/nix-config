{
  description = "My NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations = {
        sloth = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ./machines/sloth/configuration.nix ];
        };
      };
    };
}
