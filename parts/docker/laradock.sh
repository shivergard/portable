#!/bin/bash

directory=""

echo "$1"

directory="$1"
mkdir ./"$1"

echo ./"$1"/docker-compose.yml

cp "$( dirname "${BASH_SOURCE[0]}" )"/composer.yml ./"$1"/docker-compose.yml
cd ./"$1"

docker-compose up -d --force-recreate
