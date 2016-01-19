FROM debian:jessie
RUN apt-get update                                                              &&  \
    apt-get install -y --no-install-recommends                                      \
        ca-certificates                                                             \
        build-essential                                                             \
        wget                                                                        \
        curl                                                                    &&  \
    curl --silent --location https://deb.nodesource.com/setup_4.x | bash -      &&  \
    apt-get install -y --no-install-recommends                                      \
        wget                                                                        \
        mysql-client                                                                \
        rsync                                                                       \
        openssh-client                                                              \
        apache2                                                                     \
        libapache2-mod-php5                                                         \
        php5-mcrypt                                                                 \
        php5-mysql                                                                  \
        php5-curl                                                                   \
        php5-gd                                                                     \
        php5-imagick                                                                \
        nodejs                                                                      \
        ssmtp                                                                       \
        git                                                                     &&  \
    npm install -g gulp grunt-cli bower                                         &&  \
    a2enmod headers rewrite                                                     &&  \
    addgroup --system --gid 1000 user                                           &&  \
    adduser --system --uid 1000 --gid 1000 --shell /bin/bash user               &&  \
    mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist                 &&  \
    rm -r /etc/apache2/conf-enabled/ /etc/apache2/sites-enabled/                &&  \
    mkdir -p /mnt/conf/apache /mnt/www

COPY apache2.conf /etc/apache2/apache2.conf
COPY start.sh /usr/local/bin/
COPY index.php /mnt/www/

EXPOSE 80
CMD ["start.sh"]
