{
  description = "Basic Nix flake";

  inputs = {
    # Pin a stable nixpkgs release (adjust as needed)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs supportedSystems;
    calkitOverlay = final: prev: rec {
      calkit = final.python312Packages.callPackage ./calkit.nix {};
    };
    pkgsFor = f:
      forEachSystem (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [calkitOverlay];
          };
        });
  in {
    devShells = pkgsFor (
      {pkgs}: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            calkit
          ];
        };
      }
    );
  };
}
