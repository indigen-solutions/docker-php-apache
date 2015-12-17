#!/bin/bash
set -e

#initialize ssmtp
SMTP_SERVER=${SMTP_SERVER-""}
SMTP_HOSTNAME=${SMTP_HOSTNAME-$(hostname)}
SMTP_USERNAME=${SMTP_USERNAME-""}
SMTP_PASSWORD=${SMTP_PASSWORD-""}
SMTP_USE_TLS=${SMTP_USE_TLS-"false"}

if [ ! -z "$SMTP_SERVER" ]
then
    echo "hostname=${SMTP_HOSTNAME}" > /etc/ssmtp/ssmtp.conf
    echo "mailhub=${SMTP_SERVER}" >> /etc/ssmtp/ssmtp.conf
    [ ! -z "${SMTP_USERNAME}" ] && echo "AuthUser=${SMTP_USERNAME}" >> /etc/ssmtp/ssmtp.conf
    [ ! -z "${SMTP_PASSWORD}" ] && echo "AuthPass=${SMTP_PASSWORD}" >> /etc/ssmtp/ssmtp.conf
    [ "${SMTP_USE_TLS}" = "true" ] && echo "UseTLS=YES\nUseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf
    echo "FromLineOverride=yes" >> /etc/ssmtp/ssmtp.conf
fi

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

DOCUMENT_ROOT=${DOCUMENT_ROOT-"/mnt/www"}
APACHE_UMASK=${APACHE_UMASK-"002"}
APACHE_USER=${APACHE_USER-"#1000"}
APACHE_GROUP=${APACHE_GROUP-"#1000"}

umask $APACHE_UMASK

export DOCUMENT_ROOT APACHE_USER APACHE_GROUP APACHE_UMASK
exec apache2 -DFOREGROUND
