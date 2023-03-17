{
  description = "Pandoc filter to extract only the code blocks.";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          pandoc-select-code = pkgs.haskellPackages.developPackage {
            name = "pandoc-select-code";
            root = ./.;
          };
          default = pandoc-select-code;
        };
        apps = rec {
          pandoc-select-code = flake-utils.lib.mkApp { drv = self.packages.${system}.pandoc-select-code; };
          default = pandoc-select-code;
        };
      }
    );
}
