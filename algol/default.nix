{ nixpkgs ? import <nixpkgs> {} }:
{
  algol68toc = nixpkgs.stdenv.mkDerivation rec {
    name = "algol68toc";
    src = builtins.fetchTarball {
      url = http://www.nunan.myzen.co.uk/algol68/algol68toc_1.15.tar.gz;
    };
    buildInputs = with nixpkgs; [
      coreutils
      gnumake
      gnused
      which
    ];
    patches = [
      ./patchfile.patch
    ];
    installPhase = ''
      PREFIX=$out make install
    '';
  };
}
