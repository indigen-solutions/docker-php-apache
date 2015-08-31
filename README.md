# docker-php-apache

A generic php + apache docker

### Using with docker-compose

```yaml
apache:
  image: docker-registry.indigen.com/apache-php:latest
  volume:
    - ./www/:/mnt/www
    - ./conf/apache:/mnt/conf/apache
  expose:
    - 80
```

### Volume

 + **/mnt/www** is the default apache document root.
 + **/mnt/conf/apache/** can contain `*.conf` files that are loaded by apache.