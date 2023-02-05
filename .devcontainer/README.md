# Codespace for VIP WP Local Development Environment (Single Container Edition)

Welcome и всё такое

https://docs.wpvip.com/how-tos/local-development/

## Configuration Options

You may need to rebuild your codespace. All changes to the database will be lost.

The following settings in `devcontainer.json` (`containerEnv` veriable) affect the configuration of the Codespace:
  * `WPVIP_XDEBUG_ENABLE`: set to a non-empty value of `xdebug.mode` to enable XDebug (for example, `debug,coverage`);
  * `WPVIP_MULTISITE`: set to a non-empty value if you want a multi-site WordPress;
  * `WPVIP_MEDIA_REDIRECT_DOMAIN`: set to an URL to use in redirects for missing media files. This can be used to still have images without the need to import them locally.

## Useful Commands

  * `xdebug-disable`: disables XDebug;
  * `xdebug-enable`: enables XDebug;
  * `xdebug enable mode`: enables XDebug and sets `xdebug.mode` to `mode` (e.g., `xdebug-enable coverage`);
  * `set-media-redirect-domain url`: sets the media redirect domain to `url`. If `url` is empty (`set-media-redirect-domain ""`), clears the media redirect domain;
  * `sv restart service`, where service is one of `php-fpm`, `nginx`, `mailhog`, `memcached`, or `mariadb`: restarts the respective service.

## Logs

  * `/var/log/nginx/access.log`: nginx access log;
  * `/var/log/nginx/error.log`: nginx + php error log;
  * `/var/lib/mysql/${HOSTNAME}.err`: MariaDB error log.

## Ports

All forwarded ports are private by default.

  * 80 (Application): your site. If you nt to make this port public, you can run `gh codespace ports visibility 80:public -c "${CODESPACE_NAME}"`.
  * 81 (phpMyAdmin): phpMyAdmin. Please never ever make this port public, as this will make your database available to the whole world.
  * 8025 (MailHog): MailHog. It does not make sense to make this port public either.

To view all ports, you can use `gh codespace ports -c "${CODESPACE_NAME}"`

## Useful Links

  * [WordPress VIP Documentation](https://docs.wpvip.com/)
  * [Alpine Linux Wiki](https://wiki.alpinelinux.org/wiki/Main_Page)
