httpExchange() {
    if (( $# != 3 )); then
        1>&2 httpExchangeUsage
        return 1
    fi

    method=$1
    url=$2
    timeout=$3

    # The curl program accepts only positive timeouts; it treats zero timeouts
    # as no timeout. Work around this limitation.
    if (( $(bc <<< "$timeout <= 0") )); then
        timeout=1
    fi

    curl -X "$method" -m "$timeout" -- "$url"
    return "$?"
}

httpExchangeUsage() {
    echo "Usage: $0 httpEchoExchange METHOD URL TIMEOUT"
}
