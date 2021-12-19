#!/bin/bash

source variables-tmp.sh

# Рабочая версия

sudo sed -e 's/$project_name/'$project_name'/; s/$project_name./'$project_name'./' $templ_conf_bind/dev-sverch.bind.templ > /var/lib/bind/$project_name.dev-sverch.bind

# Дебаг версия

# sudo sed -e 's/$project_name/'$project_name'/; s/$project_name./'$project_name'./' $templ_conf_bind/dev-sverch.bind.templ > debug/$project_name.dev-sverch.bind
