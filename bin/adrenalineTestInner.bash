# This program implements the gist of adrenalineTest. It is not to be invoked
# by the user, but only by adrenalineTest.

set -o nounset

mainUsage() {
    echo 'Do not invoke this program manually.'
}

main() {
    if [[ ${1-} != 'XXX' ]]; then
        1>&2 mainUsage
        return 1
    fi

    ip link set dev lo up                               || return "$?"
    ip addr add 200.0.0.1/32 dev lo                     || return "$?"
    ip addr add 200.0.0.2/32 dev lo                     || return "$?"

    iptables -A INPUT -d 200.0.0.2 -j DROP              || return "$?"

    exec "${@:2}"
}

main "$@"
exit "$?"
