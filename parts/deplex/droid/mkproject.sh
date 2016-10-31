#!/system/bin/sh

# Build project : make folder , from sublime project data get folder data 
# and name folder : and rsync details :::  thinking ... thinking ...

if [ -z /sd-ext/fs/"$1" ];then
	echo 1
else
	mkdir /sd-ext/fs/"$1"
fi
