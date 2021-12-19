#!/bin/bash

source /home/p_boyko/projects/web/src/content/scripts/NG-DNS-new-project/variables-tmp.sh

# Получаем ID проекта

project_id=`curl --header "PRIVATE-TOKEN: $PRIVATE_GITLAB_TOKEN" "https://gitlab.com/api/v4/projects?search=$project_name-$1&owned=true&simple=true" | sed -r 's/,/\n/' | sed -n 1p | sed 's/\[{"id"://'`

echo "ID удалённого репозитория: " $project_id

# Получаем registration_token

registration_token=`curl --request POST --header "PRIVATE-TOKEN: $PRIVATE_GITLAB_TOKEN" "https://gitlab.com/api/v4/projects/$project_id/runners/reset_registration_token" | sed 's/{"token":"//' | sed 's/"}//'`

echo "Токен регистрации для gitlab-runner'а: " $registration_token

# Регистрируем gitlab-runner

gitlab-runner register --non-interactive --url "https://gitlab.com" --name "sverchok" --registration-token "$registration_token" --executor "shell" --tag-list "dev-shell"

service gitlab-runner restart 