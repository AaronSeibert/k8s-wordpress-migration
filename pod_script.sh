#!/bin/bash

# This script executes on the pod in order to restore the database and wp-content directory
content_dir="/bitnami/wordpress"
bin_dir="/bitnami/bin"

echo "\nRestoring database..."
mysql -u$WORDPRESS_DATABASE_USER -p$WORDPRESS_DATABASE_PASSWORD -h $MARIADB_HOST $WORDPRESS_DATABASE_NAME < /db.sql

echo "Restoring wp-content..."
tar zxvf /content.tgz -C $content_dir

echo "Installing S3-Uploads plugin"
mv /S3-Uploads /bitnami/wordpress/wp-content/plugins/

echo "Setting wp-content permissions.."
chown -R bitnami:daemon /bitnami/wordpress/wp-content

echo "\nInstalling wp-cli..."
mkdir -p $bin_dir
curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /bitnami/bin/wp
chmod +x /bitnami/bin/wp


echo "\nCleaning Up..."
rm /db.sql
rm /content.tgz
