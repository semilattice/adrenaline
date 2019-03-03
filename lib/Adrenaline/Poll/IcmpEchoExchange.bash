icmpEchoExchange() {
    if (( $# != 2 )); then
        1>&2 icmpEchoExchangeUsage
        return 1
    fi

    local address=$1
    local timeout=$2

    # The ping program accepts only integer timeouts, and it treats zero
    # timeouts as no timeout. Work around these limitations.
    printf -v timeout '%.0f' "$timeout"
    if (( $timeout <= 0 )); then
        timeout=1
    fi

    ping -c 1 -W "$timeout" -- "$address"
    return "$?"
}

icmpEchoExchangeUsage() {
    echo "Usage: $0 icmpEchoExchange ADDRESS TIMEOUT"
}