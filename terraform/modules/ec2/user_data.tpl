#!/bin/bash

WP_CONFIG="/var/www/html/wordpress/wp-config.php"

# Update database settings in wp-config.php
sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${db_name}' );/" $WP_CONFIG
sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${db_user}' );/" $WP_CONFIG
sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${db_password}' );/" $WP_CONFIG
sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', '${db_host}' );/" $WP_CONFIG


echo "session.save_handler = redis" | sudo tee -a /etc/php/7.4/fpm/php.ini
echo "session.save_path = \"tcp://${redis_host}:6379\"" | sudo tee -a /etc/php/7.4/fpm/php.ini

systemctl restart php7.4-fpm.service
