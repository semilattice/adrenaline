set -o nounset

echo '1..1'

"$ADRENALINEBIN/adrenalinePoll" icmpEchoExchange 200.0.0.2 1
if (( $? == 1 )); then
    echo 'ok 1'
else
    echo 'not ok 1'
fi
