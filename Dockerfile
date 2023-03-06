FROM php:8.1-fpm-alpine

USER root

ENV BASEDIR=/var/www/html
ENV WEBROOT $BASEDIR/web

ENV TZ Asia/Taipei

# RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer
RUN apk add --no-cache nginx git zip curl net-tools unzip tree 
RUN docker-php-ext-install bcmath
RUN apk add --no-cache --virtual .build-deps autoconf g++ make && pecl install redis && apk del .build-deps
RUN docker-php-ext-enable redis
RUN docker-php-ext-install pdo_mysql opcache mysqli

# 加速套件下載的套件
RUN composer global require hirak/prestissimo && composer clear-cache

ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh 

COPY ./src $BASEDIR

RUN composer install --working-dir=$BASEDIR  && composer clear-cache

COPY conf/default.conf /etc/nginx/sites-enabled/default.conf
COPY conf/default.conf /etc/nginx/sites-enabled/default

RUN chmod -Rf 777 /var/www/html/runtime
RUN chmod -Rf 777 /var/www/html/web/assets

EXPOSE 80
EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
