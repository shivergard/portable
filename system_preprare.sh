#!/bin/sh

sudo apt-get update
#git + Git Details
sudo apt-get -y install git

#lamp stack
sudo apt-get install -y apache2
sudo apt-get install -y mysql-server libapache2-mod-auth-mysql php-mysql
sudo mysql_install_db

sudo apt-get install -y php7.0 libapache2-mod-php php-mcrypt

#composer for laravel
sudo apt-get install -y curl
sudo sh -c "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/"

#sudo nano /etc/apache2/mods-enabled/dir.conf

sudo apt-get install -y php-sqlite

#for laravel
sudo php7enmod mcrypt
sudo a2enmod rewrite
sudo service apache2 restart

#swamp create
sudo dd if=/dev/zero of=/swapfile bs=1M count=2000
sudo chmod 600 /swapfile
mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab