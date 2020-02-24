{ nixpkgs ? import <nixpkgs> {} }:
{
  fibs = nixpkgs.stdenv.mkDerivation rec {
    name = "fibs";
    src = ./.;
    buildInputs = with nixpkgs; [
      gfortran
    ];
    buildPhase = ''
      set -e
      gfortran ${name}.F90 -o ${name}
    '';
    installPhase = ''
      set -e
      mkdir -p $out/bin/
      mv ${name} $out/bin/${name}
    '';
  };
}
