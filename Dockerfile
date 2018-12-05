FROM gregnuj/cyclops-base:latest
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apk add --no-cache \
    mariadb \
    mariadb-client

# add files in rootfs
ADD ./rootfs /

VOLUME ["/var/lib/mysql"]
EXPOSE 22 3360 8000 9001
