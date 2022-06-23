FROM php:7.4-apache

RUN a2enmod rewrite

RUN apt-get update -qq \
  && apt-get install -y git libpq-dev zip unzip \
  && apt-get clean autoclean \
  && apt-get autoremove -y

RUN docker-php-ext-install mysqli pdo pdo_mysql 

WORKDIR /var/www/html
ADD . .
ADD ./docker-files/apache-site-default.conf /etc/apache2/sites-available/000-default.conf

RUN chmod -R 777 storage bootstrap/cache

ADD ./docker-files/docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh

ADD ./docker-files/db-migrate.sh /bin/db-migrate.sh
RUN chmod +x /bin/db-migrate.sh

COPY --from=composer:1.9.1 /usr/bin/composer /usr/bin/composer

RUN composer install

ENTRYPOINT ["/bin/docker-entrypoint.sh"]

CMD ["apache2-foreground"]
