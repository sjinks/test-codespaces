#!/bin/sh

set -ex

if [ "${ENABLED}" = "true" ]; then
    : MODE="${MODE:-debug}"
    apk add --no-cache php8-pecl-xdebug
    sed "s/^xdebug\\.mode.*\$/xdebug.mode = ${MODE}/" xdebug.ini > "${PHP_INI_DIR}/conf.d/xdebug.ini"
    install -m 0755 xdebug-disable xdebug-set-mode /usr/local/bin
else
    echo "Disabling XDebug feature"
fi
