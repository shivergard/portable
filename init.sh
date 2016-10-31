#!/bin/sh

cd $(dirname $0)

exec 3>&1 
dialog  --clear --menu "Choose one:" 10 30 3 1 "System prepare"  2 "Setup /opt/portable"  2> menuchoices.$$
 
if [ $? = 1 ]
	then
	 exit;
fi

# get respose
respose=`cat menuchoices.$$`

# make decsion 
case $respose in
	1) sh system_preprare.sh; break;;
	2) sh portable.sh; break;;
esac

rm menuchoices.$$

./init.sh
