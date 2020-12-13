{
  description = "zennad's configuration flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    # hardware-config = {
    #   url = "/etc/nixos/hardware-configuration.nix";
    #   flake = false;
    # };
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
                  ];
      };
    };
}
