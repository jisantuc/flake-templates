{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ]
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          appDependencies = (ps: [
            ps.matplotlib
            ps.pandas
            ps.panel
          ]);
          pythonDevDependencies = (ps: [
            ps.black
            ps.debugpy
            ps.ipython
            ps.jupyter
          ]);
          testDependencies = (ps: [
            ps.pytest
          ]);
          devPython = pkgs.python311.withPackages
            (ps: appDependencies ps ++ pythonDevDependencies ps ++ testDependencies ps);
        in
        {
          devShells.default = pkgs.mkShell
            {
              packages = [ devPython ];
            };
        }
      );
}
