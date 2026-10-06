{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  tinyxml-2,
  gtkmm3,
  gtksourceviewmm,
  gtksourceview3,
  cairomm_1_0,
}:

stdenv.mkDerivation rec {
  pname = "illogical-impulse-microtex";
  version = "r494.0e3707f";

  src = fetchFromGitHub {
    owner = "end-4";
    repo = "MicroTeX";
    rev = "e8c6e58b1306119e51297b02f0b449fa7300416d";
    hash = "sha256-AxzSroxu6hSBaW40TJWttfIFgTAVHg1beC2qPEQPayE=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    tinyxml-2
    gtkmm3
    gtksourceviewmm
    gtksourceview3
    cairomm_1_0
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/MicroTeX
    install -Dm0755 LaTeX $out/opt/MicroTeX/LaTeX
    cp -r res $out/opt/MicroTeX/
    install -Dm0644 ../LICENSE $out/share/licenses/${pname}/LICENSE

    runHook postInstall
  '';

  meta = with lib; {
    description = "MicroTeX for illogical-impulse dotfiles";
    homepage = "https://github.com/NanoMichael/MicroTeX";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "LaTeX";
  };
}
