{pkgs ? import <nixpkgs> {}}: let
  
  calkit = pkgs.python313Packages.callPackage ./calkit.nix {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      calkit
      (python3.withPackages (ps:
        with ps; [
          calkit # Add optional dependencies if needed
          pandas
          polars
        ]))
    ];
  }
