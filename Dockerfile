#++++++++++++++++++++++++++++++++++++++
# PHP application Docker container
# See https://dockerfile.readthedocs.io/en/latest/content/DockerImages/dockerfiles/php-apache.html for customization
#++++++++++++++++++++++++++++++++++++++
FROM webdevops/php-apache:7.2

ENV PROVISION_CONTEXT "development"
ENV WEB_DOCUMENT_ROOT "/app/www"

# Deploy scripts/configurations
COPY etc/             /opt/docker/etc/

RUN ln -sf /opt/docker/etc/cron/crontab /etc/cron.d/docker-boilerplate \
    && chmod 0644 /opt/docker/etc/cron/crontab \
    && echo >> /opt/docker/etc/cron/crontab \
    && ln -sf /opt/docker/etc/php/development.ini /opt/docker/etc/php/php.ini

# Composer
RUN sh /opt/docker/etc/ssh/install-composer.sh

# Copy any initial files into the app directory. Web root is /app/www
COPY /app/* /app/

# Configure volume/workdir
WORKDIR /app/


