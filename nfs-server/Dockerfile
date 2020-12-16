ARG VERSION_ALPINE=3.8

FROM alpine:${VERSION_ALPINE}

LABEL maintainer="wljtcc@gmail.com"
LABEL site="www.inovve.com.br"

COPY exports /etc/
COPY nfsstart /
RUN mkdir /nfsshare \
    && apk update \
    && apk add --no-cache nfs-utils \
    && rm -vrf /var/cache/apk/* \
    && chmod +x /nfsstart

WORKDIR /nfsshare
CMD ["/nfsstart"]