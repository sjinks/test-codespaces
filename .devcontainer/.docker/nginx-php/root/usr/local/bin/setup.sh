#!/bin/sh

set -x

if [ -n "${CODESPACE_NAME}" ] && [ -n "${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}" ]; then
    DOMAIN="${CODESPACE_NAME}-80.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
else
    DOMAIN="localhost"
fi

exec /dev-tools/setup.sh 127.0.0.1 root "http://${DOMAIN}/" "WordPress VIP Development Site"
