#!/bin/sh

set -x

DOMAIN="${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
export WP_CLI_ALLOW_ROOT=1
/dev-tools/setup.sh database root "http://${DOMAIN}/" "Test"
nginx
echo Application is listening on http://127.0.0.1:8080
