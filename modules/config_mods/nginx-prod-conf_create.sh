#!/bin/bash

source variables-tmp.sh 

sudo sed -e 's/$project_name/'$project_name'/; s/\/$project_name./\/'$project_name'./; s/\.$project_name./.'$project_name'./; s!$path_prod!'$path_prod'!' $templ_conf_nginx/nginx.templ > /etc/nginx/sites-available/$project_name.sverch.conf

# sudo sed -e 's/$project_name/'$project_name'/; s/\/$project_name./\/'$project_name'./; s/\.$project_name./.'$project_name'./; s!$path_prod!'$path_prod'!' $templ_conf_nginx/nginx.templ > debug/$project_name.sverch.conf