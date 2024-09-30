FROM alpine:3.14

# Update package list and install necessary packages
RUN apk update && \
    apk add php7 \
           php7-fpm \
           php7-mysqli \
           php7-phar \
           curl \
           composer && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf

# Copy the create_wordpress script into the container
COPY requirements/wordpress/conf/create_wordpress.sh /usr/local/bin/create_wordpress.sh

# Make the script executable
RUN chmod +x /usr/local/bin/create_wordpress.sh

# Create the document root directory
RUN mkdir -p /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Expose the port for PHP-FPM
EXPOSE 9000

# Start PHP-FPM and then run the create_wordpress script
CMD ["sh", "-c", "/usr/local/bin/create_wordpress.sh && /usr/sbin/php-fpm7 -F"]
