FROM gregnuj/cyclops-base:alpine3.7
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
WORKDIR /var/lib/mysql
EXPOSE 22 8000 3360
CMD ["/usr/bin/supervisord", "-n"]
