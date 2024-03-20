{
  description = "My NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
    }:
    let
      user = "ryan";
    in
    {
      nixosConfigurations = {
        sloth = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./machines/sloth/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = import ./home.nix;
            }
          ];
        };
      };
    };
}
