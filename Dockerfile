FROM debian:6

RUN echo "deb http://ftp.fr.debian.org/debian/ jessie main non-free contrib" >> /etc/apt/sources.list   &&  \
    echo "deb http://archive.debian.org/debian lenny main contrib non-free"  >> /etc/apt/sources.list   &&  \
    apt-get update

COPY apt-preferences /etc/apt/preferences

RUN apt-get install -y --force-yes                                                                          \
        git-core/lenny                                                                                      \
        python/jessie                                                                                       \
        apache2/lenny                                                                                       \
        build-essential/lenny                                                                               \
        ca-certificates/lenny                                                                               \
        curl/lenny                                                                                          \
        gcc/jessie                                                                                          \
        mysql-client/lenny                                                                                  \
        openssh-client/lenny                                                                                \
        php5-cli/lenny                                                                                      \
        php5-curl/lenny                                                                                     \
        php5-mcrypt/lenny                                                                                   \
        php5-mysql/lenny                                                                                    \
        php5/lenny                                                                                          \
        rsync/lenny                                                                                         \
        unzip/lenny                                                                                         \
        wget/lenny                                                                                          \
# Next package are specified to avoid package conflict
        apache2-mpm-prefork/lenny                                                                           \
        apache2-utils/lenny                                                                                 \
        apache2.2-common/lenny                                                                              \
        libapache2-mod-php5                                                                                 \
        libaprutil1/lenny                                                                                   \
        libcurl3-gnutls/lenny                                                                               \
        libcurl3/lenny                                                                                      \
        libdbd-mysql-perl/lenny                                                                             \
        libdbi-perl/lenny                                                                                   \
        libdigest-sha1-perl/lenny                                                                           \
        libkrb53/lenny                                                                                      \
        libpq5/lenny                                                                                        \
        libssl0.9.8/lenny                                                                                   \
        mime-support/lenny                                                                                  \
        mysql-client-5.0/lenny                                                                              \
        openssl/jessie                                                                                      \
        perl-base/lenny                                                                                     \
        perl-modules/lenny                                                                                  \
        perl/lenny                                                                                          \
        ucf/lenny

RUN cd tmp                                                                                              &&  \
    wget https://github.com/nodejs/node/archive/v4.x.zip                                                &&  \
    unzip v4.x.zip                                                                                      &&  \
    cd node-4.x                                                                                         &&  \
    ./configure                                                                                         &&  \
    make                                                                                                &&  \
    make install                                                                                        &&  \
    rm -rf /tmp/*

RUN npm install -g gulp grunt-cli bower                                                                 &&  \

RUN a2enmod headers rewrite proxy proxy_http                                                            &&  \
    addgroup --system --gid 1000 user                                                                   &&  \
    adduser --system --uid 1000 --gid 1000 --shell /bin/bash user                                       &&  \
    mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist                                         &&  \
    rm -rf /etc/apache2/conf-enabled/ /etc/apache2/sites-enabled/                                       &&  \
    mkdir -p /mnt/conf/apache /mnt/www

COPY apache2.conf /etc/apache2/apache2.conf
COPY apache2-foreground /usr/local/bin/
COPY index.php /mnt/www/

EXPOSE 80
CMD ["apache2-foreground"]
