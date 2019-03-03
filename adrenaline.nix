{lib, stdenv, bash, bc, curl, makeWrapper}:
stdenv.mkDerivation {
    name = "adrenaline";
    src = lib.cleanSource ./.;
    buildInputs = [
        bash
        bc
        curl
        makeWrapper
    ];
    phases = ["unpackPhase" "installPhase"];
    installPhase = ''
        mkdir -p "$out/bin" "$out/share"

        makeWrapper '${bash}/bin/bash' "$out/bin/adrenalinePoll"            \
            --prefix 'PATH' ':' '${bc}/bin'                                 \
            --prefix 'PATH' ':' '${curl}/bin'                               \
            --set 'ADRENALINEBIN' "$out/share/bin"                          \
            --set 'ADRENALINELIB' "$out/share/lib"                          \
            --add-flags "$out/share/bin/adrenalinePoll.bash"

        cp -R 'bin' "$out/share"
        cp -R 'lib' "$out/share"
    '';
}
