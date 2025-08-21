{
  description = "Dolphin's Analytics ingest server";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.poetry2nix.url = "github:nix-community/poetry2nix";
  inputs.poetry2nix.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, flake-utils, poetry2nix }: {
    overlay = nixpkgs.lib.composeManyExtensions [
      poetry2nix.overlays.default
      (final: prev: {
        analytics-ingest = prev.poetry2nix.mkPoetryApplication {
          projectDir = ./.;
        };
      })
    ];
  } // (flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      };
    in rec {
      packages.analytics-ingest = pkgs.analytics-ingest;
      defaultPackage = pkgs.analytics-ingest;

      devShells.default = with pkgs; mkShell {
        buildInputs = [ poetry uv ];
      };
    }
  ));
}
