FROM gregnuj/cyclops-base:edge
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
EXPOSE 22 3360 8000 9001
CMD ["/usr/bin/supervisord", "-n"]
