#!/bin/sh

DOMAIN="${CODESPACE_NAME}.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
su-exec www-data:www-data /dev-tools/setup.sh database root "http://${DOMAIN}/" "Test"
nginx
echo Application is listening on http://127.0.0.1:80
