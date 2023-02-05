#!/bin/sh -x

if [ $# -lt 4 ]; then
  echo: "Syntax: setup.sh <db_host> <db_admin_user> <wp_domain> <wp_title> [<multisite_domain>]"
  exit 1
fi

db_host=$1
db_admin_user=$2
wp_url=$3
wp_title=$4
multisite_domain=$5
multisite_type=${6:-subdomains}

if [ -n "${CODESPACE_NAME}" ]; then
  multisite_type="subdirectories"
fi

sudo chown www-data:www-data /wp/config
if [ -d /wp/wp-content/uploads ]; then
  sudo chown www-data:www-data /wp/wp-content/uploads
fi

sed -e "s/%DB_HOST%/$db_host/" /dev-tools/wp-config.php.tpl > /wp/config/wp-config.php
if [ -n "$multisite_domain" ]; then
  sed -e "s/%DOMAIN%/$multisite_domain/" /dev-tools/wp-config-multisite.php.tpl >> /wp/config/wp-config.php
  if [ "${multisite_type}" != "subdomains" ]; then
    sed -i "s/define( 'SUBDOMAIN_INSTALL', true );/define( 'SUBDOMAIN_INSTALL', false );/" /wp/config/wp-config.php
  fi
fi
curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /wp/config/wp-config.php

echo "Waiting for MySQL to come online..."
second=0
while ! mysqladmin ping -uroot -h"${db_host}" --silent && [ "${second}" -lt 60 ]; do
  sleep 1
  second=$((second+1))
done
if ! mysqladmin ping -uroot -h"${db_host}" --silent; then
    echo "ERROR: mysql has failed to come online"
    exit 1;
fi

echo "Checking for database connectivity..."
if ! mysql -h "$db_host" -u wordpress -pwordpress wordpress -e "SELECT 'testing_db'" >/dev/null 2>&1; then
  echo "No WordPress database exists, provisioning..."
  echo "CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY 'wordpress'" | mysql -h "$db_host" -u "$db_admin_user"
  echo "CREATE USER IF NOT EXISTS 'wordpress'@'%' IDENTIFIED BY 'wordpress'" | mysql -h "$db_host" -u "$db_admin_user"
  echo "GRANT ALL ON *.* TO 'wordpress'@'localhost' WITH GRANT OPTION;" | mysql -h "$db_host" -u "$db_admin_user"
  echo "GRANT ALL ON *.* TO 'wordpress'@'%' WITH GRANT OPTION;" | mysql -h "$db_host" -u "$db_admin_user"
  echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -h "$db_host" -u "$db_admin_user"
fi

echo "Checking for WordPress installation..."

site_exist_check_output="$(wp option get siteurl 2>&1)"
site_exist_return_value=$?

if echo "$site_exist_check_output" | grep -Eq "(Site .* not found)|(The site you have requested is not installed)"; then
  echo "No installation found, installing WordPress..."

  wp db clean --yes 2> /dev/null
  if [ -n "$multisite_domain" ]; then
    if [ "${multisite_type}" = "subdomains" ]; then
      type="--subdomains"
    else
      type=""
    fi
    wp core multisite-install \
      --path=/wp \
      --url="$wp_url" \
      --title="$wp_title" \
      --admin_user="vipgo" \
      --admin_email="vip@localhost.local" \
      --admin_password="password" \
      --skip-email \
      --skip-plugins \
      ${type} \
      --skip-config
  else
    wp core install \
      --path=/wp \
      --url="$wp_url" \
      --title="$wp_title" \
      --admin_user="vipgo" \
      --admin_email="vip@localhost.local" \
      --admin_password="password" \
      --skip-email \
      --skip-plugins
  fi

  wp user add-cap 1 view_query_monitor
elif [ "$site_exist_return_value" != 0 ] ; then
  echo "ERROR: Could not find out if site exists."
  echo "$site_exist_check_output"
else
  echo "WordPress already installed"
fi
