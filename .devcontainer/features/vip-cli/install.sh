#!/bin/sh

set -ex

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ "${ENABLED}" = "true" ]; then
    apk add --no-cache nodejs npm
    npm i -g @automattic/vip
else
    echo "Disabling VIP CLI feature"
fi
