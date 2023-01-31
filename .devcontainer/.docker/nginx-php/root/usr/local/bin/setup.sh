#!/bin/sh

set -x

DOMAIN="${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
/dev-tools/setup.sh database root "http://${DOMAIN}/" "Test"
echo Application is listening on http://127.0.0.1:8080
