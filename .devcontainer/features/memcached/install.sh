#!/bin/sh

set -ex

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ "${ENABLED}" = "true" ]; then
    apk add --no-cache php8-pecl-memcache php8-pecl-memcached memcached
    install -D -m 0755 service-run /etc/service/memcached/run
    install -m 0644 object-cache.php object-cache-next.php object-cache-stable.php /wp/wp-content/
else
    echo "Disabling memcached feature"
fi
