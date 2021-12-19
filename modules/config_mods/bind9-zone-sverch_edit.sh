#!/bin/bash

source variables-tmp.sh

echo -e "$project_name\tIN\tA\t192.168.1.7" >> /var/lib/bind/sverch.bind

# echo -e "$project_name\tIN\tA\t192.168.1.7" >> debug/sverch.bind
