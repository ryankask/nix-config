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
      mkSystem =
        { host, system }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${host}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ryan = import ./home;
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        sloth = mkSystem {
          host = "sloth";
          system = "aarch64-linux";
        };
        flea = mkSystem {
          host = "flea";
          system = "x86_64-linux";
        };
      };
    };
}
