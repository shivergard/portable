#!/bin/sh

if [ -f $(pwd)/artisan ]
	then
	php artisan $@
else
	php ~/jsapi-lara/larnet/artisan $@
fi
