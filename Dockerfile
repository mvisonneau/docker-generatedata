FROM php:7.4-fpm-alpine

ARG BUILDPLATFORM=linux/amd64
ENV GENERATEDATA_VERSION '3.4.1'
ENV CONFD_VERSION        '0.16.0'

WORKDIR /opt/generatedata

RUN \
apk add --no-cache \
  bash \
  curl \
  git \
  libzip-dev \
  nginx \
  supervisor \
  zip ;\
docker-php-ext-install mysqli zip ;\
git clone https://github.com/benkeen/generatedata.git /opt/generatedata ;\
git checkout ${GENERATEDATA_VERSION} ;\
mkdir -p /run/nginx ;\
chown -R www-data:www-data /var/www /run/nginx ;\
chmod -R o+w /opt/generatedata/cache ;\
curl -sL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-${BUILDPLATFORM/\//-} -o /usr/local/bin/confd ;\
chmod +x /usr/local/bin/confd

ADD config/confd /etc/confd
ADD config/supervisord.conf /etc/supervisord.conf
ADD config/php.ini /usr/local/etc/php/php.ini
ADD config/php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf
ADD config/nginx.conf /etc/nginx/nginx.conf

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 8080

RUN \
  chown -R 101:101 /opt/generatedata

# Run as nginx user
USER 101:101

ENTRYPOINT [ "/docker-entrypoint.sh" ]
