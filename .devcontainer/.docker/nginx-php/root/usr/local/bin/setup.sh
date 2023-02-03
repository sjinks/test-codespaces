#!/bin/sh

set -x

if [ -n "${CODESPACE_NAME}" ] && [ -n "${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}" ]; then
    DOMAIN="${CODESPACE_NAME}-80.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
else
    DOMAIN="localhost"
fi

/dev-tools/setup.sh 127.0.0.1 root "http://${DOMAIN}/" "WordPress VIP Development Site"

if [ -n "${CODESPACE_VSCODE_FOLDER}" ]; then
    for i in client-mu-plugins images languages plugins themes; do
        rm -rf "/wp/wp-content/${i}"
        ln -sf "${CODESPACE_VSCODE_FOLDER}/${i}" "/wp/wp-content/${i}"
    done
fi
