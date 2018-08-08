FROM gregnuj/cyclops-base:stretch
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apt-get update \
    && apt-get install -y \
    mariadb-server \
    mariadb-client \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

# add files in rootfs
ADD ./rootfs /

VOLUME ["/var/lib/mysql"]
WORKDIR /var/lib/mysql
EXPOSE 22 3360
CMD ["/usr/bin/supervisord", "-n"]
