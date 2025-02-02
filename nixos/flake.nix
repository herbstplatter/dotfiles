{
  description = "ughhh flakes";

  # test test
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules =  [ ./configuration.nix  ];
        };
      };

      homeConfigurations = {
        herbst = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
	  modules = [ ./home-manager/home.nix ]; # Must be located at '~/.config/home-manager/'. You can make a symlink for it.
	};
      };
    };
}
