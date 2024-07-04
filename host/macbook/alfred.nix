{ stdenv, fetchurl, undmg, unzip }:
let
  version = "5.5_2257";
in

stdenv.mkDerivation rec {
  inherit version;

  name = "Alfred-${version}";
  buildInputs = [ undmg unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "Alfred 5.app" "$out/Applications/Alfred 5.app"
    '';

  src = fetchurl {
    name = "Alfred_${version}.dmg";
    url = "https://cachefly.alfredapp.com/Alfred_${version}.dmg";
    sha256 = "sha256-7tfiG1MfOXTM1EDxzFa6POai/tLUE4ZKnEpObypje1Q";
  };
}