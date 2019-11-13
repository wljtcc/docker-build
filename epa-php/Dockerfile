#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM debian:stretch-slim
LABEL maintainer="Wellington Luiz <https://github.com/wljtcc>"
LABEL version="dockersimeon/epa:php7.1.3"

#------------------------------------------------------------------------------
# Install:
#------------------------------------------------------------------------------

COPY install.sh /
COPY run.sh /etc/init.d/
RUN sh /install.sh
COPY php.ini /etc/php/7.1/apache2/
COPY apache2.conf /etc/apache2/

#------------------------------------------------------------------------------
# Expose ports, entrypoint and command:
#------------------------------------------------------------------------------

WORKDIR /var/www/html
EXPOSE 80
ENTRYPOINT ["/etc/init.d/run.sh"]
