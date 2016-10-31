#!/bin/bash
userNnm=$(whoami)
echo $(pwd)
cd /opt/portable/sub
if [[ $userNnm =~ .*uest.* ]]
then
        cp -r $(pwd)/config/sublime-text-2 ~/.config/sublime-text-2
        cp -r $(pwd)/bin/sublime ~/sublime

else
	ln -s $(pwd)/config/sublime-text-2 ~/.config/sublime-text-2
	ln -s $(pwd)/bin/sublime ~/sublime
fi
~/sublime/sublime_text
rm -fR ~/.config/sublime-text-2
rm -fR ~/sublime
