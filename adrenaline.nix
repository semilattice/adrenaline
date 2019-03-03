{lib, stdenv, bash, bc, makeWrapper}:
stdenv.mkDerivation {
    name = "adrenaline";
    src = lib.cleanSource ./.;
    buildInputs = [
        bash
        bc
        makeWrapper
    ];
    phases = ["unpackPhase" "installPhase"];
    installPhase = ''
        mkdir -p "$out/bin" "$out/share"

        makeWrapper '${bash}/bin/bash' "$out/bin/adrenalinePoll"            \
            --set 'ADRENALINEBIN' "$out/share/bin"                          \
            --set 'ADRENALINELIB' "$out/share/lib"                          \
            --add-flags "$out/share/bin/adrenalinePoll.bash"

        cp -R 'bin' "$out/share"
        cp -R 'lib' "$out/share"
    '';
}
