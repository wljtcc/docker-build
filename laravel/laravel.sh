#!/bin/sh

cd /var/www/localhost/htdocs

php artisan config:cache
#php artisan route:cache
composer dump-autoload
composer install