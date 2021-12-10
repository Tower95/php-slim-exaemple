FROM php:7.4-fpm

RUN apt update \
    && apt install -y zlib1g-dev libicu-dev libzip-dev libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install intl opcache pdo pdo_pgsql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

WORKDIR /var/www/slim_app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./composer* ./

RUN composer install

COPY ./ ./

CMD [ "php", "-S", "0.0.0.0:8080", "-t", "public", "public/index.php" ]