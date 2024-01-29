{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ]
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          compiler = "ghc96";
          haskellPackages = pkgs.haskell.packages.${compiler};
          packageDependencies = (ps: [
            ps.optparse-applicative
            ps.text
          ]);
          devDependencies = with haskellPackages; [
            cabal-install
            cabal-fmt
            haskell-language-server
            hlint
            ormolu
          ];
          testDependencies = (ps: [
            ps.hspec
            ps.hspec-discover
          ]);
          haskell = haskellPackages.ghcWithPackages
            (ps: packageDependencies ps ++ testDependencies ps);
        in
        {
          devShells.default = pkgs.mkShell
            {
              packages = [ haskell ] ++ devDependencies;
            };

          packages.default = haskellPackages.callCabal2nix "project-name" ./. { };
        }
      );
}
