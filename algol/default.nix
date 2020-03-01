{ nixpkgs ? import <nixpkgs> {} }:
{
  algol68g = nixpkgs.stdenv.mkDerivation {
    name = "algol68g";
    src = builtins.fetchTarball {
      url = https://jmvdveer.home.xs4all.nl/algol68g-2.8.4.tar.gz;
    };
  };
}
