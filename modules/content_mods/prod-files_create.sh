#!/bin/bash

source variables-tmp.sh

sed -e 's/$project_name/'$project_name'/; s/\/$project_name./\/'$project_name'./' $templ_cap_prod/index.templ > $path_prod/$project_name.sverch/index.html

sudo chown -R www-data:www-data $path_prod/$project_name.sverch
