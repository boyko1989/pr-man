#!/bin/bash

source variables-tmp.sh
prod="$path_prod/$project_name.sverch"

mkdir $prod
chown -R www-data:www-data $prod
