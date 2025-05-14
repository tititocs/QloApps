FROM php:8.2-apache

# Copia todos los archivos del proyecto al directorio raíz del servidor web
COPY . /var/www/html/

# Habilita el módulo de reescritura de Apache
RUN a2enmod rewrite

# Establece el directorio de trabajo
WORKDIR /var/www/html/

# Exponer el puerto 80
EXPOSE 80
