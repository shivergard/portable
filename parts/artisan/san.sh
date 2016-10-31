#!/bin/sh

if [ -f $(pwd)/artisan ]
	then
	php artisan $@
else
	php /opt/jsapi-lara/larnet/artisan $@
fi
