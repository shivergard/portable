#!/bin/sh

if [ ! -f ~/.alias ]
then

   if [ ! -f /opt/portable/alias/alias.txt ]
	then
	    echo "source ~/.alias" >> ~/.bashrc
	    echo "#This must stay at END" > ~/.alias
	    echo "alias realias='unalias -a;source ~/.alias'" > ~/.alias
	    echo "alias alias='nano ~/.alias;realias;'" >> ~/.alias
   else
	echo "source ~/.alias" >> ~/.bashrc
	cp /opt/portable/alias/alias.txt ~/.alias
   fi
fi

exec bash
