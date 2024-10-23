FROM wordpress:6.6.2

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Automattic/jetpack-production/archive/refs/tags/13.9.tar.gz -P /var/www/html/wp-content/plugins/
RUN tar -xvzf /var/www/html/wp-content/plugins/13.9.tar.gz --directory /var/www/html/wp-content/plugins/
RUN rm /var/www/html/wp-content/plugins/13.9.tar.gz
RUN mv /var/www/html/wp-content/plugins/jetpack-production-13.9 /var/www/html/wp-content/plugins/jetpack
