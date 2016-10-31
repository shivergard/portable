#!/bin/bash

base_=$(pwd)
base_name="${base_##*/}"

DOMAIN=$base_name
host_id=$(( ( RANDOM )  + 1 ))

if [ -z "$1" ] ;
	then
	me=`basename $0`
	echo "Define rand '$me [0/1]'"
	exit;
else 
	if [ "$1" = "1" ];
		then
		DOMAIN="$base_name$host_id"
		echo "rand domain $DOMAIN"
	else
		if [ "$1" != "0" ];
			then
			DOMAIN="$1"
			echo "selected domain $DOMAIN"
		fi		
	fi
fi

chown -R www-data $(pwd)

echo "127.0.0.1       $DOMAIN" | sudo tee --append /etc/hosts  > /dev/null
echo "127.0.0.1       www.$DOMAIN" | sudo tee --append /etc/hosts  > /dev/null

echo "<VirtualHost *:80>" > ~/.$DOMAIN.conf
echo "  DocumentRoot FOLDER" >> ~/.$DOMAIN.conf
echo "  ServerName DOMAIN" >> ~/.$DOMAIN.conf
echo "" >> ~/.$DOMAIN.conf
echo "  <Directory FOLDER >" >> ~/.$DOMAIN.conf
echo "    Options All" >> ~/.$DOMAIN.conf
echo "    AllowOverride All" >> ~/.$DOMAIN.conf
echo "    Require all granted" >> ~/.$DOMAIN.conf
echo "  </Directory>" >> ~/.$DOMAIN.conf
echo "</VirtualHost>" >> ~/.$DOMAIN.conf

sudo sed -i "s+FOLDER+$base_+g" ~/.$DOMAIN.conf
sudo sed -i "s+DOMAIN+$DOMAIN+g" ~/.$DOMAIN.conf

mv ~/.$DOMAIN.conf /etc/apache2/sites-available/$DOMAIN.conf


sudo a2ensite $DOMAIN
sudo service apache2 reload
