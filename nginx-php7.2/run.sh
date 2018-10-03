#!/bin/sh

# Start NGINX
php-fpm7
# Start NGINX
nginx -g "daemon on;"

tail -f /var/log/nginx/error.log