ARG ALPINE_VERSION=3.10.1

FROM alpine:${ALPINE_VERSION}

LABEL maintainer="wljtcc@gmail.com"
LABEL site="www.inovve.com.br"

ADD install.sh /
ADD run.sh /usr/local/bin
ADD laravel.sh /usr/local/bin
RUN rm -rf /etc/nginx/nginx.conf
ADD nginx/nginx.conf /etc/nginx/
RUN chmod +x /usr/local/bin/run.sh \
    && chmod +x /usr/local/bin/laravel.sh
RUN sh /install.sh
RUN rm /install.sh

WORKDIR /var/www/localhost/htdocs

EXPOSE 80

CMD [ "run.sh" ]