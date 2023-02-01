#!/bin/sh

set -x

/sbin/runsvdir -P /etc/sv &
pid="$!"

echo Container started
trap "exit 0" 15
wait $pid
