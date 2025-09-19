{
  description = "Basic Nix flake";

  inputs = {
    # Pin a stable nixpkgs release (adjust as needed)
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs supportedSystems;

    calkitOverlay = final: prev: rec {
      docx2pdf = final.python312Packages.callPackage ./docx2pdf.nix {};
      arithmeval = final.python312Packages.callPackage ./arithmeval.nix {};
      calkit = final.python312Packages.callPackage ./calkit.nix {inherit arithmeval docx2pdf;};
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
            docx2pdf
          ];
        };
      }
    );
  };
}
