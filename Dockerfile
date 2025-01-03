# Use an official PHP image as a base
FROM php:8.1-apache

# Install required dependencies for Moodle
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmysqlclient-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mysqli

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set up Moodle
WORKDIR /var/www/html
RUN curl -o moodle.zip https://download.moodle.org/latest.zip
RUN unzip moodle.zip
RUN rm moodle.zip
RUN mv moodle /var/www/html/moodle

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html/moodle

# Expose the necessary port
EXPOSE 80
