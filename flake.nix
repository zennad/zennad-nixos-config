{
  description = "zennad's configuration flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
  outputs = { self, nixpkgs }: {
    nixosConfigurations."nixos.zennad" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
