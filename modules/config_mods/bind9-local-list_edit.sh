#!/bin/bash

source variables-tmp.sh


# Старая рабочая версия

# echo -e "\nzone \"$project_name.dev-sverch\" {\n\ttype master;\n\tfile \"/var/lib/bind/$project_name.dev-sverch.bind\";\n};" >> /etc/bind/named.conf.local

# Старая дебаг версия

# echo -e "\nzone \"$project_name.dev-sverch\" {\n\ttype master;\n\tfile \"/var/lib/bind/$project_name.dev-sverch.bind\";\n};" >> debug/named.conf.local

# ----------------------------------------------------------------------------------------


# Экспериментальная дебаг-версия
# > named.conf.local
# По списку создаем по шаблону записи в файле

# i=1
# while (( i <= count_strings ))
# do
# 	name_zone=$(sed -n "$i"p zones.list)
# 	sed 's/$name_zone/'$name_zone'/' $templ_conf_bind/zone-list-item.templ >> named.conf.local
# 	let i++
# done

# Рабочая версия

count_strings=$(wc zones.list | awk '{print $2}')
# По списку создаем по шаблону записи в файле
> /etc/bind/named.conf.local
i=1
while (( i <= count_strings ))
do
	name_zone=$(sed -n "$i"p zones.list)
	sed 's/$name_zone/'$name_zone'/' $templ_conf_bind/zone-list-item.templ >> /etc/bind/named.conf.local
	let i++
done

