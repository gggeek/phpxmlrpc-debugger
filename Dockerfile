ARG UBUNTU_VERSION=jammy

FROM ubuntu:${UBUNTU_VERSION}

# other possible org.opencontainers.image labels: title, vendor
LABEL org.opencontainers.image.source=https://github.com/gggeek/phpxmlrpc-debugger
LABEL org.opencontainers.image.description="An xmlrpc and jsonrpc graphical debugger, made available as Docker container "
LABEL org.opencontainers.image.licenses=BSD

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
  chmod 755 /root/entrypoint.sh && \
  apt-get autoremove -y && \
  apt-get purge -y --auto-remove && \
  rm -rf /var/lib/apt/lists/* /var/log/alternatives.log /var/log/apt/* /var/log/dpkg.log

# has to be here for the www-data user to exist
COPY --chown=www-data:www-data src /var/www/html/

RUN /root/setup/setup_app.sh /var/www/html && \
    rm -rf /root/.cache/composer/

EXPOSE 80 443

# @todo can we avoid hardcoding this here? We can f.e. get it passed down as ARG...
WORKDIR /var/www/html

ENTRYPOINT ["/root/entrypoint.sh"]
