{
  description = "zennad's configuration flake";
  outputs = { self, ... }:
    {
      nixosModules = {
        zennad-config = import ./configuration.nix;
        nix-version = import ./nix-version.nix;
      };
    };
}

