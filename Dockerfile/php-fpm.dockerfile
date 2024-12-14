FROM php:fpm
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-enable mysqli

# Set PHP configuration
RUN echo "post_max_size = 64M" >> /usr/local/etc/php/php.ini && \
    echo "upload_max_filesize = 64M" >> /usr/local/etc/php/php.ini && \
    echo "memory_limit = 128M" >> /usr/local/etc/php/php.ini