{ nixpkgs ? import <nixpkgs> {} }:
let
  assembly-program = name: nixpkgs.stdenv.mkDerivation {
    name = name;
    src = ./.;
    buildInputs = with nixpkgs; [
      nasm
      gcc
    ];
    buildPhase =
      let
        format = if builtins.currentSystem == "x86_64-linux"
          then "elf64"
          else "macho64";
        ldFlags = if builtins.currentSystem == "x86_64-linux"
          then ""
          else "-macosx_version_min 10.7.0 -lSystem";
      in ''
        set -e
        nasm -f ${format} ${name}.asm
        ld ${ldFlags} -o ${name} ${name}.o
      '';
    installPhase = ''
      set -e
      mkdir -p $out/bin/
      mv ${name} $out/bin/${name}
    '';
  };
in
{
  hello-world = assembly-program "hello-world";
  fibs = assembly-program "fibs";
}
