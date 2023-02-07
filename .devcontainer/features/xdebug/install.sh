#!/bin/sh

set -ex

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ "${ENABLED}" = "true" ]; then
    : MODE="${MODE:-debug}"
    apk add --no-cache php8-pecl-xdebug
    sed "s/^xdebug\\.mode.*\$/xdebug.mode = ${MODE}/" xdebug.ini > "${PHP_INI_DIR}/conf.d/xdebug.ini"
    install -m 0755 xdebug-disable xdebug-set-mode /usr/local/bin
else
    echo "Disabling XDebug feature"
fi
