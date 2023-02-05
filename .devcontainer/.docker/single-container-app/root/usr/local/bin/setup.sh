#!/bin/sh

if [ -n "${CODESPACE_NAME}" ] && [ -n "${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}" ]; then
    DOMAIN="${CODESPACE_NAME}-80.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
else
    DOMAIN="${WPVIP_DOMAIN_OVERRIDE:-localhost}"
fi

if [ -z "${WPVIP_MULTISITE}" ]; then
    /dev-tools/setup.sh 127.0.0.1 root "http://${DOMAIN}" "WordPress VIP Development Site"
else
    /dev-tools/setup.sh 127.0.0.1 root "http://${DOMAIN}" "WordPress VIP Development Site" "${DOMAIN}" "${WPVIP_MULTISITE_TYPE}"
fi

if [ -n "${RepositoryName}" ]; then
    base=/workspaces/${RepositoryName}
else
    base=$(pwd)
fi

for i in client-mu-plugins images languages plugins themes vip-config; do
    sudo rm -rf "/wp/wp-content/${i}"
    sudo ln -sf "${base}/${i}" "/wp/wp-content/${i}"
done
