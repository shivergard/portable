#!/bin/bash

NOW=$(date +"%m-%d-%Y")
FILE="hosts.$NOW.txt"
cp /etc/hosts /opt/bckups/$FILE

if [ -z "$1" ];
	then
		echo "" > /opt/bckups/tmpList
		sed '/facebook.com/d;/vk.com/d' /etc/hosts >> /opt/bckups/tmpList
		mv /opt/bckups/tmpList /etc/hosts
		#echo $HOSTDATA >> /opt/bckups/sss
	exit
else
	echo "127.0.1.1      vk.com" >> /etc/hosts
	echo "127.0.1.1      facebook.com" >> /etc/hosts
	echo "127.0.1.1      www.facebook.com" >> /etc/hosts
fi

echo "chrome://net-internals/#dns"