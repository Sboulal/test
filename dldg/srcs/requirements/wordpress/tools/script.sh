#!/bin/bash



# if ! wp core --path="/var/www/html" --allow-root is-installed; then
# 	wp core --path="/var/www/html" --allow-root is-installed
# 	echo "DOWNLOADING ... " $?

# 	wp core download --path="/var/www/html" --allow-root

# 	wp config create --skip-check --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --dbprefix="$WP_PREFIX" --path="/var/www/html" --allow-root 

# 	if ! wp --allow-root db check; then
# 		exit 1
# 	fi

# 	echo "CREATE DATABASE $MYSQL_DATABASE ;"

# 	wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html" --allow-root 


# fi

# sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# chmod -R 777 /var/www/html
# service php7.4-fpm start

# service php7.4-fpm stop

# php-fpm7.4 -F

#!/bin/bash

# cd /var/www/html

# rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

# sed -i "s/wp_name/$DB_NAME/" /wp-config.php
# sed -i "s/wp_username/$MYSQL_USER/" /wp-config.php
# sed -i "s/wp_pass/$MYSQL_PASSWORD/" /wp-config.php


mv wp-cli.phar /usr/local/bin/wp && chmod +x /usr/local/bin/wp

# cp /wp-config.php /var/www/html/


sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

wp core download --allow-root

wp config create --skip-check --dbname=$DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost='mariadb' --allow-root

wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

# wp theme install twentysixteen --activate --allow-root

#changing the listen directive to a TCP socket

# sed -i 's,listen = /run/php/php7.4-fpm.sock,listen = 0.0.0.0:9000,' /etc/php/7.4/fpm/pool.d/www.conf

mkdir /run/php

/usr/sbin/php-fpm7.4 -F