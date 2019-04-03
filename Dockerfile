FROM php:7.3-fpm-alpine3.9
MAINTAINER Maxime VISONNEAU <maxime.visonneau@gmail.com>

ENV GENERATEDATA_VERSION '3.2.8'
ENV CONFD_VERSION        '0.16.0'

WORKDIR /opt/generatedata

RUN \
apk add --no-cache bash supervisor nginx git ;\
docker-php-ext-install mysqli ;\
git clone https://github.com/benkeen/generatedata.git /opt/generatedata ;\
git checkout ${GENERATEDATA_VERSION} ;\
mkdir -p /run/nginx ;\
chown -R www-data:www-data /var/www /run/nginx ;\
chmod -R o+w /opt/generatedata/cache

ADD https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 /usr/local/bin/confd
ADD config/confd /etc/confd
RUN chmod +x /usr/local/bin/confd

ADD config/supervisord.conf /etc/supervisord.conf
ADD config/php.ini /usr/local/etc/php/php.ini
ADD config/php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf
ADD config/nginx.conf /etc/nginx/nginx.conf

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT [ "/docker-entrypoint.sh" ]
