{lib, stdenv, bash, bc, curl, iptables, makeWrapper}:
stdenv.mkDerivation {
    name = "adrenaline";
    src = lib.cleanSource ./.;
    buildInputs = [
        bash
        bc
        curl
        iptables
        makeWrapper
    ];
    phases = ["unpackPhase" "installPhase"];
    installPhase = ''
        mkdir -p "$out/bin" "$out/share"

        bashProgram() {
            makeWrapper '${bash}/bin/bash' "$out/bin/$1"                    \
                --prefix 'PATH' ':' '${bc}/bin'                             \
                --prefix 'PATH' ':' '${curl}/bin'                           \
                --prefix 'PATH' ':' '${iptables}/bin'                       \
                --set 'ADRENALINEBIN' "$out/bin"                            \
                --set 'ADRENALINELIB' "$out/share/lib"                      \
                --add-flags "$out/share/bin/$1.bash"
        }

        bashProgram 'adrenalinePoll'
        bashProgram 'adrenalineTest'
        bashProgram 'adrenalineTestInner'

        cp -R 'bin' "$out/share"
        cp -R 'lib' "$out/share"
    '';
}
