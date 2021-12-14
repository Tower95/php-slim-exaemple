FROM php:7.2.34-cli

RUN apt update \
    && apt install -y zlib1g-dev g++ git libicu-dev zip libzip-dev zip libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install intl opcache pdo pdo_pgsql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN git config --global user.email "torrestmi3@gmail.com" \
    && git config --global user.name "Tower95"

WORKDIR /var/www/slim_app

COPY ./composer* ./

RUN composer install

COPY ./ ./

CMD [ "php", "-S", "0.0.0.0:8080", "-t", "public", "public/index.php" ]