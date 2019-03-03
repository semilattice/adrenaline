set -o nounset

source "$ADRENALINELIB/Adrenaline/Poll/HttpExchange.bash"
source "$ADRENALINELIB/Adrenaline/Poll/IcmpEchoExchange.bash"

main() {
    case ${1-} in
        (icmpEchoExchange) icmpEchoExchange "${@:2}" ; return "$?" ;;
        (httpExchange)     httpExchange     "${@:2}" ; return "$?" ;;
        (*)                1>&2 mainUsage            ; return 1    ;;
    esac
}

mainUsage() {
    echo "Usage: $0 POLLTYPE [ARGUMENT ...]"
}

main "$@"
exit "$?"
