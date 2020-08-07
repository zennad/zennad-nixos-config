{
  description = "zennad's configuration flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    hardware-config.url = "/etc/nixos/hardware-configuration.nix";
    hardware-config.flake = false;
  };
  outputs = { self, nixpkgs, hardware-config }: {
    nixosConfigurations."nixos.zennad" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
    nixosModules = [ hardware-config ];
  };
}
