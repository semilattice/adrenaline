# This program will set up a test environment and run the given command in that
# environment. Within the test environment, limited networking is available,
# with useful rules for testing. The following special addresses are available,
# with specific behavior each:
#
# Address       Behavior
# 200.0.0.1     Loopback address
# 200.0.0.2     Drop all packets

set -o nounset

mainUsage() {
    echo "Usage: $0 PROGRAM [ARGUMENT ...]"
}

main() {
    if (( $# == 0 )); then
        1>&2 mainUsage
        return 1
    fi

    exec unshare -rn -- "$ADRENALINEBIN/adrenalineTestInner" XXX "$@"
}

main "$@"
exit "$?"
