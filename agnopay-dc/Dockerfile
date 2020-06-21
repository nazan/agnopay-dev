FROM php:7.2.25-apache-buster

ARG UID
ARG GID

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN mkdir -p /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN apt-get update && apt-get install --no-install-recommends --yes git unzip libpng-dev libzip-dev libicu-dev

RUN git config --global url."https://".insteadOf git://

RUN docker-php-ext-install bcmath

RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-configure zip --with-libzip && docker-php-ext-install zip

RUN docker-php-ext-install exif

RUN docker-php-ext-configure intl && docker-php-ext-install intl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install xdebug-2.6.0 && docker-php-ext-enable xdebug

RUN a2enmod rewrite

RUN mkdir -p /usr/src/aidock/build

RUN if grep -q "^appuser" /etc/group; then echo "Group already exists."; else groupadd -g $GID appuser; fi
RUN useradd -m -r -u $UID -g appuser appuser

