ARG UBUNTU_VERSION=noble

FROM ubuntu:${UBUNTU_VERSION}

# other possible org.opencontainers.image labels: title, vendor
LABEL org.opencontainers.image.source=https://github.com/gggeek/phpxmlrpc-debugger
LABEL org.opencontainers.image.description="An xmlrpc and jsonrpc graphical debugger, made available as Docker container "
LABEL org.opencontainers.image.licenses=BSD

ARG PHP_VERSION=default

COPY --chmod=755 docker/setup/*.sh /root/setup/
COPY docker/config/* /root/config/
COPY --chmod=755 docker/entrypoint.sh /root/entrypoint.sh
COPY src /var/www/html_/

RUN mkdir -p /usr/share/man/man1 && \
  cd /root/setup && \
  ./install_packages.sh -u && \
  ./setup_apache.sh && \
  ./setup_php.sh "${PHP_VERSION}" && \
  ./setup_composer.sh && \
  rm -rf /var/www/html && mv /var/www/html_ /var/www/html && chown -R www-data:www-data /var/www/html && \
  /root/setup/setup_app.sh /var/www/html && \
  rm -rf /root/.cache/composer/ && \
  ./remove_packages.sh && \
  apt-get autoremove -y && apt-get -y autoclean && apt-get -y clean && apt-get purge -y --auto-remove && \
  rm -rf /var/lib/apt/lists/* /var/log/alternatives.log /var/log/apt/* /var/log/dpkg.log

EXPOSE 80 443

# @todo can we avoid hardcoding this here? We can f.e. get it passed down as ARG...
WORKDIR /var/www/html

ENTRYPOINT ["/root/entrypoint.sh"]
