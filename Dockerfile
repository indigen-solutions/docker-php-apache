FROM debian:jessie
RUN apt-get update							&& \
    apt-get install -y --no-install-recommends				   \
        apache2								   \
        libapache2-mod-php5						   \
        php5-mcrypt							   \
	php5-imagick							&& \
    a2enmod headers rewrite						&& \
    addgroup --system --gid 1000 user					&& \
    adduser --system --uid 1000 --gid 1000 user				&& \
    mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist		&& \
    rm -r /etc/apache2/conf-enabled/ /etc/apache2/sites-enabled/	&& \
    mkdir -p /mnt/conf/apache /mnt/www

COPY apache2.conf /etc/apache2/apache2.conf
COPY apache2-foreground /usr/local/bin/

EXPOSE 80
CMD ["apache2-foreground"]