FROM php:7.4-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    unzip \
    zip \
    && docker-php-ext-install gd pdo_mysql soap zip

# Activar mod_rewrite
RUN a2enmod rewrite

# Copiar archivos al servidor
COPY . /var/www/html/

# Ajustar configuración PHP
RUN echo "upload_max_filesize = 16M" >> /usr/local/etc/php/php.ini && \
    echo "post_max_size = 20M" >> /usr/local/etc/php/php.ini

# Establecer permisos (recomendado, aunque Render ejecuta como root)
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 775 /var/www/html/config \
                 /var/www/html/cache \
                 /var/www/html/log \
                 /var/www/html/img \
                 /var/www/html/mails \
                 /var/www/html/modules \
                 /var/www/html/themes/hotel-reservation-theme/lang \
                 /var/www/html/themes/hotel-reservation-theme/pdf/lang \
                 /var/www/html/themes/hotel-reservation-theme/cache \
                 /var/www/html/translations \
                 /var/www/html/upload \
                 /var/www/html/download

WORKDIR /var/www/html/

EXPOSE 80
