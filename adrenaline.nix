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
        mkdir -p "$out/bin" "$out/share/test"

        bashProgram() {
            mkdir -p "$(dirname "$out/bin/$1")"
            makeWrapper '${bash}/bin/bash' "$out/bin/$1"                    \
                --prefix 'PATH' ':' '${bc}/bin'                             \
                --prefix 'PATH' ':' '${curl}/bin'                           \
                --prefix 'PATH' ':' '${iptables}/bin'                       \
                --set 'ADRENALINEBIN' "$out/bin"                            \
                --set 'ADRENALINELIB' "$out/share/lib"                      \
                --add-flags "$out/share/bin/$1.bash"
        }

        bashTest() {
            mkdir -p "$(dirname "$out/bin/test/$1")"
            makeWrapper "$out/bin/adrenalineTest" "$out/bin/test/$1"        \
                --set 'ADRENALINEBIN' "$out/bin"                            \
                --add-flags bash                                            \
                --add-flags "$out/share/test/$1.bash"
        }

        bashProgram 'adrenalinePoll'
        bashProgram 'adrenalineTest'
        bashProgram 'adrenalineTestInner'

        bashTest 'adrenalinePoll/icmpEchoExchange/success'
        bashTest 'adrenalinePoll/icmpEchoExchange/timeout'

        cp -R 'bin'  "$out/share"
        cp -R 'lib'  "$out/share"
        cp -R 'test' "$out/share"
    '';
}
