#!/bin/bash

source variables-tmp.sh

nginx -t >& /dev/null
nginx_status=$?

named-checkconf /etc/bind/named.conf
bind_status=$?

# echo "NGINX: $nginx_status"
# echo "BIND: $bind_status"

let "all_status=$nginx_status+$bind_status"
# echo "ALL: $all_status"

if [ $all_status -eq 0 ]
then
	systemctl restart nginx
	systemctl restart named
fi

# if [ $all_status -eq 0 ]
# then
# 	echo "systemctl restart nginx"
# 	echo "systemctl restart named"
# fi