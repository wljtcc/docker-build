#!/bin/sh

# Run Install app Laravel
laravel.sh

# Start NGINX
php-fpm7
# Start NGINX
nginx -g "daemon on;"

tail -f /var/log/nginx/error.log