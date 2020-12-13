{
  description = "zennad's configuration flake";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.03;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
  };
  outputs = { self
            , nixpkgs
            , nixos-hardware
            , ... }:
    {
      nixosConfigurations."nixos.zennad" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix
                    ./hardware-configuration.nix
                    nixpkgs.nixosModules.notDetected
                    nixos-hardware.nixosModules.lenovo-thinkpad-t420
                  ];
      };
    };
}
