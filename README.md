# docker-php-apache

A generic php + apache docker

### Using with docker-compose

```yaml
apache:
  image: indigen/php-apache
  volume:
    - ./www/:/mnt/www
    - ./conf/apache:/mnt/conf/apache
    - ./scripts/start.sh:/mnt/scripts/start.sh
  environment:
    - DOCUMENT_ROOT=/mnt/www
  expose:
    - 80
```

### Volume

 + **/mnt/www** is the default apache document root.
 + **/mnt/conf/apache/** can contain `*.conf` files that are loaded by apache.
 + **/mnt/scripts/start/** can contain `*.sh` files that are executed before apache start.

### Environment
  + **DOCUMENT_ROOT**: By default the apache DocumentRoot is located in /mnt/www.
  + **APACHE_USER**: By default the apache user is set to #1000. Because the container have his own passwd file you must use #UID notation.
  + **APACHE_GROUP**: By default the apache group is set to #1000. Because the container have his own group file you must use #GID notation.
  + **APACHE_UMASK**: By default the apache umask is set to 002.
