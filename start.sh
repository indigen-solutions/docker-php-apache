#!/bin/bash
set -e

if [ -z "$APACHE_RUN_DIR" ]
then
    APACHE_RUN_DIR=/var/run/apache2/
fi

if [ -z "$DOCUMENT_ROOT" ]
then
    DOCUMENT_ROOT="/mnt/www"
fi

if [ -z "$UMASK" ]
then
    APACHE_UMASK="002"
fi

if [ -z "$APACHE_USER" ]
then
    APACHE_USER="#1000"
fi

if [ -z "$APACHE_GROUP" ]
then
    APACHE_GROUP="#1000"
fi

# Apache gets grumpy about PID files pre-existing
rm -f "$APACHE_RUN_DIR/apache2.pid"

mkdir -p "$APACHE_RUN_DIR"
umask $APACHE_UMASK

# Exec all prestart scripts
for file in $(find /mnt/scripts/start/ -name "*.sh" | sort)
do
    sh $file;
done

export DOCUMENT_ROOT APACHE_USER APACHE_GROUP APACHE_UMASK APACHE_RUN_DIR
exec apache2 -DFOREGROUND
