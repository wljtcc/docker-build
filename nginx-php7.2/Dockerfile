ARG ALPINE_VERSION=3.8

FROM alpine:${ALPINE_VERSION}

LABEL maintainer="wljtcc@gmail.com"
LABEL site="www.inovve.com.br"

ADD install.sh /
ADD run.sh /
RUN chmod +x /run.sh
RUN sh /install.sh
RUN rm /install.sh

CMD [ "/run.sh" ]