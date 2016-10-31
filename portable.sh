#!/bin/sh

sudo mkdir /opt/portable
sudo chmod -fR 777 /opt/portable

#move default moving parts
cp -r ./parts/* /opt/portable

sudo chmod -fR 777 /opt/portable

#Run Alias (Install them)
/opt/portable/alias/alias.sh

