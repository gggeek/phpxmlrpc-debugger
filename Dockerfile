ARG UBUNTU_VERSION=jammy

FROM ubuntu:${UBUNTU_VERSION}

ARG PHP_VERSION=default

COPY docker/setup/*.sh /root/setup/
COPY docker/config/* /root/config/
COPY docker/entrypoint.sh /root/entrypoint.sh

RUN mkdir -p /usr/share/man/man1 && \
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
  chmod 755 /root/setup/*.sh && \
  cd /root/setup && \
  ./install_packages.sh && \
  ./setup_apache.sh && \
  ./setup_php.sh "${PHP_VERSION}" && \
  ./setup_composer.sh && \
  chmod 755 /root/entrypoint.sh

# has to be here for the www-data user to exist
COPY --chown=www-data:www-data src /var/www/html/

RUN /root/setup/setup_app.sh /var/www/html && \
    /root/setup/cleanup_build.sh

EXPOSE 80 443

# @todo can we avoid hardcoding this here? We can f.e. get it passed down as ARG...
WORKDIR /var/www/html

ENTRYPOINT ["/root/entrypoint.sh"]
