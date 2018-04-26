#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM mariadb:10.3.6
LABEL MAINTAINER="Wellington Luiz <https://github.com/wljtcc>"

#------------------------------------------------------------------------------
# Install:
#------------------------------------------------------------------------------

RUN mv /etc/mysql/my.cnf /etc/mysql/my.cnf.old
ADD ./my.cnf /etc/mysql/my.cnf
RUN chmod 0644 /etc/mysql/my.cnf
