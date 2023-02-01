#!/bin/sh

set -x

DOMAIN="${CODESPACE_NAME}-80.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
/usr/bin/mysqladmin -uroot password ''
/dev-tools/setup.sh 127.0.0.1 root "http://${DOMAIN}/" "Test"
