location ~* /wp-content/uploads {
    expires max;
    log_not_found off;
    try_files $uri @prod_site;
}

location @prod_site {
    rewrite ^/(.*)$ ${WPVIP_MEDIA_REDIRECT_DOMAIN}/$1 redirect;
}
