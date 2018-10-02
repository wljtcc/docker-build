ARG PHP_VERSION=7.2.10-fpm-alpine3.8

FROM php:${PHP_VERSION}

LABEL maintainer="wljtcc@gmail.com"
LABEL site="www.inovve.com.br"

RUN apk update \
    && apk add --no-cache php7-pdo_pgsql \
    && apk add --update postgresql-dev freetype-dev libpng-dev libjpeg-turbo-dev freetype libpng libjpeg-turbo git\
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd pdo pdo_pgsql opcache zip \
    && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev \
    && apk del

#ADD composer.json /var/www/html
#ADD composer.lock /var/www/html
WORKDIR /var/www/html
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    ##&& composer install -o --no-dev
    #&& composer create-project laravel/laravel --prefer-dist

EXPOSE 8000
ENTRYPOINT [ "composer install -o --no-dev" ]
ENTRYPOINT [ "php artisan config:cache" ]

CMD [ "php", "artisan", "serve", "--host=0.0.0.0"]
