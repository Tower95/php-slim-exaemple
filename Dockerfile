FROM composer

WORKDIR /var/www/slim_app

COPY ./composer* ./

RUN composer install

COPY ./ ./

CMD [ "php", "-S", "0.0.0.0:8080", "-t", "public", "public/index.php" ]