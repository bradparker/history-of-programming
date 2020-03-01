{ nixpkgs ? import <nixpkgs> {} }:
rec {
  hello-world = nixpkgs.stdenv.mkDerivation rec {
    name = "hello-world";
    src = ./.;
    installPhase = ''
      mkdir -p $out/{bin,lib}
      cp ./${name}.alg $out/lib/
      echo "#!${nixpkgs.bash}/bin/bash" > $out/bin/${name}
      echo "${algol68g}/bin/a68g $out/lib/${name}.alg" >> $out/bin/${name}
      chmod +x $out/bin/${name}
    '';
  };
  algol68g = nixpkgs.stdenv.mkDerivation {
    name = "algol68g";
    src = builtins.fetchTarball {
      url = https://jmvdveer.home.xs4all.nl/algol68g-2.8.4.tar.gz;
    };
  };
}
