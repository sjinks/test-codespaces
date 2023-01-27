#!/bin/sh

DOMAIN="localhost.localdomain"

if [ -n "${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}" ] && [ -n "${CODESPACE_NAME}" ]; then
    DOMAIN="${CODESPACE_NAME}.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
fi

if [ "$(id -u)" = "0" ]; then
    su-exec www-data:www-data /dev-tools/setup.sh database root "http://${DOMAIN}/" "Test"
    nginx
    echo Application is listening on http://127.0.0.1:80
else
    /dev-tools/setup.sh database root "http://${DOMAIN}/" "Test"
fi