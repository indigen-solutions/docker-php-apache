#!/bin/bash
set -e

#init apache vars
APACHE_RUN_DIR=${APACHE_RUN_DIR-"/var/run/apache2"}
DOCUMENT_ROOT=${DOCUMENT_ROOT-"/mnt/www"}
APACHE_UMASK=${APACHE_UMASK-"002"}
APACHE_USER=${APACHE_USER-"#1000"}
APACHE_GROUP=${APACHE_GROUP-"#1000"}

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
mkdir -p "${APACHE_RUN_DIR}"
rm -f "${APACHE_RUN_DIR}/apache2.pid"
umask $APACHE_UMASK

# Exec all prestart scripts
for file in $(find /mnt/scripts/start/ -name "*.sh" | sort)
do
    sh $file;
done


export DOCUMENT_ROOT APACHE_USER APACHE_GROUP APACHE_UMASK APACHE_RUN_DIR
exec apache2 -DFOREGROUND
