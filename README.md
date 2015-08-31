# docker-php-apache

A generic php + apache docker

### Using with docker-compose

```yaml
apache:
  image: indigen/php-apache
  volume:
    - ./www/:/mnt/www
    - ./conf/apache:/mnt/conf/apache
  expose:
    - 80
```

### Volume

 + **/mnt/www** is the default apache document root.
 + **/mnt/conf/apache/** can contain `*.conf` files that are loaded by apache.

### Environment
  + **DOCUMENT_ROOT**: By default the apache DocumentRoot is located in /mnt/www.