{
  description = "pensieve";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      inherit (pkgs) boolector mkShell python3 racket;
    in
    {
      # NOTE: `raco pkg install rosette` needs to be run manually.
      devShells.default = mkShell {
        packages = [
          boolector
          (python3.withPackages (ps:
            let inherit (ps) matplotlib numpy; in [
              matplotlib
              numpy
            ]))
          racket
        ];
      };
    });
}
