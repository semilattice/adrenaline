icmpEchoExchangeUsage() {
    echo "Usage: $0 icmpEchoExchange ADDRESS TIMEOUT"
}

icmpEchoExchange() {
    # Send an ICMP echo request to some host and await the corresponding ICMP
    # echo response. If the ICMP echo response does not arrive in time, or it
    # is ill-formed, fail with a non-zero status. Otherwise, print the time it
    # took for the ICMP echo response to arrive.

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

    ping -c 1 -W "$timeout" -- "$address"                                   \
        | icmpEchoExchangeExtractTime
    return "${PIPESTATUS[0]}"
}

icmpEchoExchangeExtractTime() {
    # Extract the ping time from the output of the ping command, and convert it
    # into a number of seconds.

    local dt=$(grep -Po -m 1 '(?<=time=)[0-9.]+(?= ms)')
    if [[ $dt != '' ]]; then
        bc <<< "scale = 4; $dt / 1000.0"
    fi
}
