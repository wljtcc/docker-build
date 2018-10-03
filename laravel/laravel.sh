#!/bin/sh

cd /var/www/localhost/htdocs

composer install
php artisan config:cache
php artisan route:cache
