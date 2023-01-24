FROM ghcr.io/automattic/vip-container-images/nginx:1.23.2

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
