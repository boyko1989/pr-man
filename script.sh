#!/bin/bash

# ---------------------------------------------------- #
#                                                      #
#    Данный файл является образцом и в выполнении команды    # 
#    pr-man участия принимать не будет !!!                # 
#                                                      #
# ---------------------------------------------------- #

if [ "$(id -u)" != 0 ]
then
	echo "В доступе отказано! Требуются административные права." >&2
	exit 1
fi

# echo; read -p "Введите название проекта: " project_name; echo;
project_name=$1
# npm_version=`npm -v | sed 's/^\(.\).*/\1/'`

# [[ $npm_version -lt 7 ]] && { echo 'Обновите NPM до последней версии: sudo npm install -g npm'  ; exit 1 ; }

# Промежуточный файл с переменными от пользователя
sed "s/project_name/project_name=$project_name/" variables.sh > variables-tmp.sh

# Прочтение файла с текущими переменными
source variables-tmp.sh

# ---------------------------------------------------------------------------------------------------------------------

## Создание папок и файлов:
$path_content/prod-dirs_create.sh								# Создание и настройка прав для PROD-папки
sudo -u p_boyko $path_content/dev-dirs_create.sh				# Создание и настройка прав для DEV-папки
# npm install -g npm create mode 100644 #src/#src/img/icons/p-right.svg
sudo -u gitlab-runner $path_content/runner-dirs_create.sh		# Создание и настройка прав для папки runner'а

# Создание заглушек
$path_content/prod-files_create.sh								# Создание и настройка прав для PROD-заглушек
sudo -u p_boyko $path_content/dev-files_create.sh				# Создание и настройка прав для DEV-заглушек

echo " - Каталог в $path_prod/$project_name.sverch создан!"
echo " - Каталог ~/projects/web/$project_name со всем содержимым создан!"

## Делаем проекты видимыми через браузер

# -------------------------- BIND9 --------------------------

echo -e "$project_name.dev-sverch" >> zones.list
$path_config/bind9-local-list_edit.sh							# Добавление информации о зоне $project_name.dev-sverch
$path_config/bind9-dev-zone_create.sh							# Создание файла зоны $project_name.dev-sverch
$path_config/bind9-zone-sverch_edit.sh							# Редактирование файла зоны sverch.

# -------------------------- NGINX --------------------------

$path_config/nginx-prod-conf_create.sh							# Создаю файл конфигурации PROD-хоста
$path_config/nginx-dev-conf_create.sh							# Создаю файл файл конфигурации DEV-хоста
$path_config/nginx-sim.sh										# Создаю симлинки для витруальных хостов

$path_config/test.sh											# Тест и перезапуск сервисов

# --------------------------- NPM ---------------------------

$path_content/runner-files_create.sh 	# NPM-наполнение runner-папки lay
sudo -u p_boyko $path_content/dev-files_edit.sh		# NPM-наполнение DEV-папки lay

# GIT/Gitlab папок в ~/projects -----------------------------

cd $path_dev/$project_name/lay							# LAY

sudo -u p_boyko $path_git/git_create.sh lay
$path_git/gitlab_create.sh lay

cd $path_dev/$project_name/back							# BACK

sudo -u p_boyko $path_git/git_create.sh back
$path_git/gitlab_create.sh back

cd $path_dev/$project_name/content						# CONTENT

sudo -u p_boyko $path_git/git_create.sh content
$path_git/gitlab_create.sh content

cd $path_dev/$project_name/front						# FRONT

sudo -u p_boyko $path_git/git_create.sh front
$path_git/gitlab_create.sh front

# -----------------------------------------------------------

## Удаление промежуточных файлов
rm -rf variables-tmp.sh
echo "Готово!"
