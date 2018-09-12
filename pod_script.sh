#!/bin/bash

# This script executes on the pod in order to restore the database and wp-content directory
content_dir="/bitnami/wordpress"

echo "\nRestoring database..."
mysql -u$WORDPRESS_DATABASE_USER -p$WORDPRESS_DATABASE_PASSWORD -h $MARIADB_HOST $WORDPRESS_DATABASE_NAME < /db.sql

echo "Restoring wp-content..."
tar zxvf /content.tgz -C $content_dir
chown -R bitnami:daemon /bitnami/wordpress/wp-content


echo "\nCleaning Up..."
rm /db.sql
rm /content.tgz
