{
  description = "Bowen Tu's Flake File";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
  {
      packages.${system}.default = pkgs.hello;
      
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.hello ];
      };
  };
}
