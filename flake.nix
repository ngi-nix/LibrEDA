{
  description = "A new libre software framework for the physical design of digital integrated circuits.";

  inputs = {
    # Nixpkgs / NixOS version to use.
    nixpkgs.url = "nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Upstream source tree(s).
    splay = {
      url = "git+https://codeberg.org/LibrEDA/splay";
      flake = false;
    };
    libreda-db = {
      url = "git+https://codeberg.org/LibrEDA/libreda-db?rev=80d6d78c1a";
      flake = false;
    };
    iron-shapes = {
      url = "git+https://codeberg.org/LibrEDA/iron-shapes";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, flake-utils, crane, ... }@inputs:
    let      
      # Generate a user-friendly version numer.
      versions =
        let
          generateVersion = builtins.substring 0 8;
        in
          nixpkgs.lib.genAttrs
            [ "splay" "libreda-db" "iron-shapes" ]
            (n: generateVersion inputs."${n}".lastModifiedDate);

      local_overlay = import ./pkgs inputs versions;
      
      pkgsForSystem = system: import nixpkgs {
        # if you have additional overlays, you may add them here
        overlays = [
          local_overlay
        ];
        inherit system;
      };
    in flake-utils.lib.eachDefaultSystem (system: rec {
      legacyPackages = pkgsForSystem system;

      packages = flake-utils.lib.flattenTree {
        default = legacyPackages.libreda.splay;
      };

      # Default shell
      devShells.default = legacyPackages.mkShell {
        packages = [
          packages.default
        ];
      };
    }) // {
      overlays = {
        default = final: prev: local_overlay.libreda;
        all = final: prev: local_overlay.libreda;
      };
    };
}
