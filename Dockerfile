FROM debian:squeeze
RUN echo "deb http://archive.debian.org/debian squeeze main non-free contrib" > /etc/apt/sources.list                           &&  \
    echo "deb-src http://archive.debian.org/debian/ squeeze main non-free contrib" >> /etc/apt/sources.list                     &&  \
    echo "deb http://archive.debian.org/debian-security/ squeeze/updates main non-free contrib" >> /etc/apt/sources.list        &&  \
    echo "deb-src http://archive.debian.org/debian-security/ squeeze/updates main non-free contrib" >> /etc/apt/sources.list    &&  \
    apt-get update                                                                                                              &&  \
    apt-get install -y --no-install-recommends                                                                                      \
        ca-certificates                                                                                                             \
        wget                                                                                                                        \
        curl                                                                                                                    &&  \
    echo "deb http://packages.dotdeb.org squeeze all" > /etc/apt/sources.list.d/dotdeb.list                                     &&  \
    wget -qO - https://www.dotdeb.org/dotdeb.gpg | apt-key add -                                                                &&  \
    apt-get update                                                                                                              &&  \
    apt-get install -y --no-install-recommends                                                                                      \
        php5-cli                                                                                                                    \
        mysql-client                                                                                                                \
        rsync                                                                                                                       \
        openssh-client                                                                                                              \
        apache2                                                                                                                     \
        libapache2-mod-php5                                                                                                         \
        php5-mcrypt                                                                                                                 \
        php5-mysql                                                                                                                  \
        php5-curl                                                                                                                   \
        php5-gd                                                                                                                     \
        php5-imagick                                                                                                                \
        ssmtp                                                                                                                       \
        git                                                                                                                     &&  \
    a2enmod headers rewrite                                                                                                     &&  \
    groupadd --system --gid 1000 user                                                                                           &&  \
    useradd --system --uid 1000 --gid 1000 --shell /bin/bash user                                                               &&  \
    mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist                                                                 &&  \
    rm -r /etc/apache2/sites-enabled/                                                                                           &&  \
    mkdir -p /mnt/conf/apache /mnt/www /mnt/scripts/start

COPY apache2.conf /etc/apache2/apache2.conf
COPY start.sh /usr/local/bin/
COPY index.php /mnt/www/

EXPOSE 80
CMD ["start.sh"]
