FROM debian:jessie
RUN apt-get update                                                              &&  \
    apt-get install -y --no-install-recommends                                      \
        ca-certificates                                                             \
        build-essential                                                             \
        curl                                                                    &&  \
    curl --silent --location https://deb.nodesource.com/setup_4.x | bash -      &&  \
    apt-get install -y --no-install-recommends                                      \
        mysql-client                                                                \
        rsync                                                                       \
        apache2                                                                     \
        libapache2-mod-php5                                                         \
        php5-mcrypt                                                                 \
        php5-mysql                                                                  \
        php5-curl                                                                   \
        php5-imagick                                                                \
        nodejs                                                                      \
        git                                                                     &&  \
    npm install -g gulp grunt-cli bower                                         &&  \
    a2enmod headers rewrite                                                     &&  \
    addgroup --system --gid 1000 user                                           &&  \
    adduser --system --uid 1000 --gid 1000 --shell /bin/bash user               &&  \
    mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist                 &&  \
    rm -r /etc/apache2/conf-enabled/ /etc/apache2/sites-enabled/                &&  \
    mkdir -p /mnt/conf/apache /mnt/www

COPY apache2.conf /etc/apache2/apache2.conf
COPY apache2-foreground /usr/local/bin/
COPY index.php /mnt/www/

EXPOSE 80
CMD ["apache2-foreground"]