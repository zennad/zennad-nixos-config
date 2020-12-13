{
  description = "zennad's configuration flake";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.03;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
  };
  outputs = { self, ... }:
    {
      nixosModules = {
        zennad-config = import ./configuration.nix;
      };
    };
}
