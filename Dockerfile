FROM wordpress:6.6.2

# Updating system.
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*

# HTTPS configuration.
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/localhost.key -out /tmp/localhost.crt -subj "/C=US/ST=YourState/L=YourCity/O=YourOrganization/CN=localhost"
RUN mv /tmp/localhost.crt /etc/ssl/certs/localhost.crt
RUN mv /tmp/localhost.key /etc/ssl/private/localhost.key
COPY conf/my-httpd-vhosts.conf /etc/apache2/sites-available/my-ssl.conf
RUN a2enmod ssl && \
    a2enmod rewrite && \
    a2dissite 000-default default-ssl && \
    a2ensite my-ssl

# Installing vulnerable Jetpack.
RUN wget https://github.com/Automattic/jetpack-production/archive/refs/tags/13.9.tar.gz -P /var/www/html/wp-content/plugins/
RUN tar -xvzf /var/www/html/wp-content/plugins/13.9.tar.gz --directory /var/www/html/wp-content/plugins/
RUN rm /var/www/html/wp-content/plugins/13.9.tar.gz
RUN mv /var/www/html/wp-content/plugins/jetpack-production-13.9 /var/www/html/wp-content/plugins/jetpack
