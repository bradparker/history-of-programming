{ nixpkgs ? import <nixpkgs> {} }:
rec {
  algol-program = name: nixpkgs.stdenv.mkDerivation {
    name = name;
    src = ./.;
    installPhase = ''
      mkdir -p $out/{bin,lib}
      cp ./${name}.alg $out/lib/
      echo "#!${nixpkgs.bash}/bin/bash" > $out/bin/${name}
      echo "${algol68g}/bin/a68g $out/lib/${name}.alg" >> $out/bin/${name}
      chmod +x $out/bin/${name}
    '';
  };

  fibs = algol-program "fibs";

  hello-world = algol-program "hello-world";

  algol68g = nixpkgs.stdenv.mkDerivation {
    name = "algol68g";
    src = builtins.fetchTarball {
      url = https://jmvdveer.home.xs4all.nl/algol68g-2.8.4.tar.gz;
    };
  };
}
