#!/bin/sh

set -ex

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ "${ENABLED}" = "true" ]; then
    apk add --no-cache phpmyadmin
    install -d -m 0777 -o www-data -g www-data /usr/share/webapps/phpmyadmin/tmp
    install -m 0640 -o www-data -g www-data config.inc.php /etc/phpmyadmin/config.inc.php
    install -m 0640 nginx-phpmyadmin.conf /etc/nginx/http.d/phpmyadmin.conf
else
    echo "Disabling phpMyAdmin feature"
fi