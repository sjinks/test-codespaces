#!/bin/sh

set -x

/sbin/runsvdir -P /etc/sv &
pid="$!"

echo Container started
/usr/local/bin/setup.sh
trap "exit 0" 15
wait $pid
