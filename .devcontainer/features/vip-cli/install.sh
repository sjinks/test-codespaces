#!/bin/sh

set -ex

if [ "${ENABLED}" = "true" ]; then
    apk add --no-cache nodejs npm
    npm i -g @automattic/vip
else
    echo "Disabling VIP CLI feature"
fi
