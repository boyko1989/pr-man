#!/bin/bash

if [ "$(id -u)" != 0 ]
then
	echo "В доступе отказано! Требуются административные права." >&2
	exit 1
fi

# echo; read -p "Введите название проекта: " project_name; echo;
project_name=$1

# Промежуточный файл с переменными от пользователя
sed "s/project_name/project_name=$project_name/" variables.sh > variables-tmp.sh

# Прочтение файла с текущими переменными
source variables-tmp.sh

[[ "$(id -u)" != 0 ]] && { echo "В доступе отказано! Требуются административные права." >&2 ; exit 1 ; }

nginx -t >& /dev/null
nginx_status=$?

named-checkconf /etc/bind/named.conf
bind_status=$?

let "all_status=$nginx_status+$bind_status"

## Режим частичного удаления проекта (только локальные файлы)

# Работающая версия ------------------------------------------------------------------

[[ -d /home/p_boyko/projects/web/$project_name ]] && rm -rf /home/p_boyko/projects/web/$project_name
[[ -d /var/www/$project_name.sverch ]] && rm -rf rm -rf /var/www/$project_name.sverch
[[ -d /home/gitlab-runner/projects/$project_name ]] && rm -rf /home/gitlab-runner/projects/$project_name

# Удалить запись из /etc/bind/named.conf.local
sed '/'$1'/d' zones.list > zones-tmp.list
cat zones-tmp.list > zones.list
rm zones-tmp.list

$path_config/bind9-local-list_edit.sh
# ---------------------------------------------

[[ -f /var/lib/bind/$project_name.dev-sverch.bind ]] && rm -f /var/lib/bind/$project_name.dev-sverch.bind

# Удалить A-запись из файла /var/lib/bind/sverch.bind
sed '/'$1'/d' /var/lib/bind/sverch.bind > sverch.bind
cat sverch.bind > /var/lib/bind/sverch.bind
rm sverch.bind

# ---------------------------------------------

[[ -f /etc/nginx/sites-available/$project_name.sverch.conf ]] && rm -f /etc/nginx/sites-available/$project_name.sverch.conf
[[ -f /etc/nginx/sites-available/$project_name.dev-sverch.conf ]] && rm -f /etc/nginx/sites-available/$project_name.dev-sverch.conf

rm -f /etc/nginx/sites-enabled/$project_name.dev-sverch.conf
rm -f /etc/nginx/sites-enabled/$project_name.sverch.conf

[[ $all_status -eq 0 ]] && { systemctl restart nginx; systemctl restart named ; }

# ---------------------------------------------

## Режим полного удаления проекта (локальные файлы + Gitlab-репозиторий)

# API-запрос:
# curl -H 'Content-Type: application/json' -H 'Private-Token: $privatetoken' -X DELETE https://gitlab.com/api/v4/projects/$namespace%2F$projectname

curl -H 'Content-Type: application/json' -H "Private-Token: $PRIVATE_GITLAB_TOKEN" -X DELETE https://gitlab.com/api/v4/projects/boyko1989%2F$project_name

curl -H 'Content-Type: application/json' -H "Private-Token: $PRIVATE_GITLAB_TOKEN" -X DELETE https://gitlab.com/api/v4/projects/boyko1989%2F$project_name-lay

curl -H 'Content-Type: application/json' -H "Private-Token: $PRIVATE_GITLAB_TOKEN" -X DELETE https://gitlab.com/api/v4/projects/boyko1989%2F$project_name-back

curl -H 'Content-Type: application/json' -H "Private-Token: $PRIVATE_GITLAB_TOKEN" -X DELETE https://gitlab.com/api/v4/projects/boyko1989%2F$project_name-content

curl -H 'Content-Type: application/json' -H "Private-Token: $PRIVATE_GITLAB_TOKEN" -X DELETE https://gitlab.com/api/v4/projects/boyko1989%2F$project_name-front

rm -rf variables-tmp.sh
echo "Готово!"
