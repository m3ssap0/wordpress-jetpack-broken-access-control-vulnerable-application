FROM wordpress:6.6.2

# Updating system.
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget nano
RUN rm -rf /var/lib/apt/lists/*

# Multisite .htaccess file.
COPY .htaccess /var/www/html/.htaccess

# Installing vulnerable Jetpack.
RUN wget https://github.com/Automattic/jetpack-production/archive/refs/tags/13.9.tar.gz -P /var/www/html/wp-content/plugins/
RUN tar -xvzf /var/www/html/wp-content/plugins/13.9.tar.gz --directory /var/www/html/wp-content/plugins/
RUN rm /var/www/html/wp-content/plugins/13.9.tar.gz
RUN mv /var/www/html/wp-content/plugins/jetpack-production-13.9 /var/www/html/wp-content/plugins/jetpack
