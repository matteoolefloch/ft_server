#UPDATE & INSTALL PACKAGES
apt-get update
apt-get upgrade -y
apt-get -y install mariadb-server
apt-get -y install wget
apt -y install php-{mbstring,zip,gd,xml,pear,gettext,cli,fpm,cgi}
apt-get -y install php-mysql
apt-get install -y libnss3-tools
apt-get -y install nginx

#NGINX SETUP
cd
mkdir -p /var/www/localhost
cp /root/nginx-host-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

#SLL SETUP
mkdir ~/mkcert && \
  cd ~/mkcert && \
  wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 && \
  mv mkcert-v1.1.2-linux-amd64 mkcert && \
  chmod +x mkcert
./mkcert -install
./mkcert localhost

#DATABASE SETUP
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
cd
mysql wordpress -u root --password=  < wordpress.sql

#WORDPRESS INSTALL
cd
cp wordpress.tar.gz /var/www/localhost/
cd /var/www/localhost/
tar -xf wordpress.tar.gz
rm wordpress.tar.gz

#PHPMYADMIN INSTALL
cd
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz
mkdir /var/www/localhost/phpmyadmin
tar xzf phpMyAdmin-4.9.0.1-english.tar.gz --strip-components=1 -C /var/www/localhost/phpmyadmin
cp /root/config.inc.php /var/www/localhost/phpmyadmin/

#ALLOW NGINX USER
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

#SERVICE STARTER
service mysql restart
/etc/init.d/php7.3-fpm start
service nginx restart
