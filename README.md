# docker-php-apache

A generic php + apache docker

### Using with docker-compose

```yaml
apache:
  image: indigen/php-apache
  volume:
    - ./www/:/mnt/www
    - ./conf/apache:/mnt/conf/apache
  environment:
    - DOCUMENT_ROOT=/mnt/www
  expose:
    - 80
```

### Volume

 + **/mnt/www** is the default apache document root.
 + **/mnt/conf/apache/** can contain `*.conf` files that are loaded by apache.

### Environment
  + **DOCUMENT_ROOT**: By default the apache DocumentRoot is located in /mnt/www.
  + **APACHE_USER**: By default the apache user is set to #1000. Because the container have his own passwd file you must use #UID notation.
  + **APACHE_GROUP**: By default the apache group is set to #1000. Because the container have his own group file you must use #GID notation.
  + **APACHE_UMASK**: By default the apache umask is set to 002.
  + **SMTP_SERVER**: Set an smtp server for the sendmail command (No smtp config will be generated if not provided)
  + **SMTP_HOSTNAME**: Default email sender domain (default to machine hostname)
  + **SMTP_USERNAME**: SMTP user
  + **SMTP_PASSWORD**: SMTP password
  + **SMTP_USE_TLS**: Use SMTP tls if set to "true"
