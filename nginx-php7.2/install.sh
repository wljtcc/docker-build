#!/bin/bash

# Install Packages
apk update
apk add --no-cache \
    nginx \
    php7 \
    php7-common \
    php7-fpm \
    php7-mcrypt \
    php7-mbstring \
    php7-soap \
    php7-openssl \
    php7-gmp \
    php7-pdo_odbc \
    php7-json \
    php7-dom \
    php7-pdo \
    php7-zip \
    php7-mysqli \
    php7-sqlite3 \
    php7-apcu \
    php7-pdo_pgsql \
    php7-bcmath \
    php7-gd \
    php7-odbc \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    php7-gettext \
    php7-xmlreader \
    php7-xmlrpc \
    php7-bz2 \
    php7-iconv \
    php7-pdo_dblib \
    php7-curl \
    php7-ctype \
    php7-tokenizer \
    tzdata

adduser -D -g 'www' www

# Defining ENV variables which will be used in configuration.
PHP_FPM_USER="www"
PHP_FPM_GROUP="www"
PHP_FPM_LISTEN_MODE="0660"
PHP_MEMORY_LIMIT="512M"
PHP_MAX_UPLOAD="50M"
PHP_MAX_FILE_UPLOAD="200"
PHP_MAX_POST="100M"
PHP_DISPLAY_ERRORS="On"
PHP_DISPLAY_STARTUP_ERRORS="On"
PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
PHP_CGI_FIX_PATHINFO=0

# Modifying configuration file php-fpm.conf
sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.conf
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.conf
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.conf
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.conf
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.conf
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.conf

# Modifying configuration file php.ini
sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini

TIMEZONE="America/Sao_Paulo"
cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo "${TIMEZONE}" > /etc/timezone
sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini

echo "<?php
	phpinfo();
?>" | tee -a /var/www/localhost/htdocs/phpinfo.php

# Config NGINX
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.default
rm /etc/nginx/nginx.conf

echo "user                            www;
worker_processes                1;

error_log                       /var/log/nginx/error.log warn;
pid                             /var/run/nginx.pid;

events {
    worker_connections          1024;
}

http {
    include                     /etc/nginx/mime.types;
    default_type                application/octet-stream;
    sendfile                    on;
    access_log                  /var/log/nginx/access.log;
    keepalive_timeout           3000;
    server {
        listen                  80;
        root                    /var/www/localhost/htdocs;
        index                   index.html index.htm index.php;
        server_name             localhost;
        client_max_body_size    32m;
        error_page              500 502 503 504  /50x.html;
        location = /50x.html {
              root              /var/lib/nginx/html;
        }
        location ~ \.php$ {
              fastcgi_pass      127.0.0.1:9000;
              fastcgi_index     index.php;
              include           fastcgi.conf;
        }
    }
}" | tee -a /etc/nginx/nginx.conf


echo "
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>NGINX - Online</title>
</head>
<body>
    Server is Online
</body>
</html>" | tee -a /var/www/localhost/htdocs/index.html

# Clean Cache APK
apk del
rm -rf /var/cache/apk/*

# Start NGINX
# php-fpm7
# Start NGINX
# nginx -g "daemon on;"
