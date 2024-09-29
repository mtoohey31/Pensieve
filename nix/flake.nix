{
  description = "pensieve";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      inherit (pkgs) bitwuzla boolector cvc5 hyperfine mkShell python3 racket
        z3;
    in
    {
      # NOTE: `raco pkg install rosette` needs to be run manually.
      devShells.default = mkShell {
        packages = [
          bitwuzla
          boolector
          cvc5
          hyperfine
          (python3.withPackages (ps:
            let inherit (ps) matplotlib numpy; in [
              matplotlib
              numpy
            ]))
          racket
          z3
        ];
      };
    });
}
