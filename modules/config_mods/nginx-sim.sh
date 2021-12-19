#!/bin/bash

source variables-tmp.sh

ln -sf /etc/nginx/sites-available/$project_name.sverch.conf /etc/nginx/sites-enabled/$project_name.sverch.conf
ln -sf /etc/nginx/sites-available/$project_name.dev-sverch.conf /etc/nginx/sites-enabled/$project_name.dev-sverch.conf