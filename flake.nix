{
  description = "zennad's configuration flake";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
  };
  outputs = { self, ... }:
    {
      nixosModules = {
        zennad-config = import ./configuration.nix;
        nix-version = import ./nix-version.nix;
      };
    };
}
