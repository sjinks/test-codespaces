#!/bin/sh

set -ex

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ "${ENABLED}" = "true" ]; then
    if [ "$(arch)" = "arm64" ]; then
        wget -q https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_arm -O /usr/local/bin/mailhog
    else
        wget -q https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64 -O /usr/local/bin/mailhog
    fi

    chmod 0755 /usr/local/bin/mailhog
    install -m 0644 php-mailhog.ini "${PHP_INI_DIR}/conf.d/mailhog.ini"
    install -D -d -m 0755 /etc/service/mailhog
    install -m 0755 service-run /etc/service/mailhog/run
else
    echo "Disabling MailHog feature"
fi
