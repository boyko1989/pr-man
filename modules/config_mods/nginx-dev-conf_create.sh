#!/bin/bash

source variables-tmp.sh 

sudo sed -e 's/$project_name/'$project_name'/; s/\/$project_name./\/'$project_name'./; s/\.$project_name./.'$project_name'./; s!$path_dev!'$path_dev'!' $templ_conf_nginx/dev-nginx.templ > /etc/nginx/sites-available/$project_name.dev-sverch.conf

# sudo sed -e 's/$project_name/'$project_name'/; s/\/$project_name./\/'$project_name'./; s/\.$project_name./.'$project_name'./; s!$path_dev!'$path_dev'!' $templ_conf_nginx/dev-nginx.templ > debug/$project_name.dev-sverch.conf
