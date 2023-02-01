#!/bin/sh

set -x

DOMAIN="${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
/dev-tools/setup.sh 127.0.0.1 root "http://${DOMAIN}/" "Test"
