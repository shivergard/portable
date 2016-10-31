#!/bin/sh

if [ -z "$1" ]
then
echo "Input ssh creditals"
exit;
fi

#check key exists
if [ ! -f ~/.ssh/id_rsa ]; then
ssh-keygen -t rsa -C "$UNAME@greenbox.lv" -f ~/.ssh/id_rsa
fi

#put it to server
# Copy your public key to the remote server
cat ~/.ssh/id_rsa.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'

# ssh is very strict about correct permissions
ssh -i ~/.ssh/id_rsa $1 'chmod g-w,o-w ~; chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys'
