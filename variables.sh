#!/bin/bash

PRIVATE_GITLAB_TOKEN=""
IP
project_name

## Пути

path_dev="/home/p_boyko/projects/web"           # путь к dev-проекту
path_prod="/var/www"							# путь к prod-проекту
gitlab_dev="/home/gitlab-runner/projects"       # путь к папке gitlab-runner'а

# к модулям

path_git="/home/p_boyko/projects/web/src/content/scripts/NG-DNS-new-project/modules/git_mods"			 # модули работы с GIT/Gitlab
path_config="modules/config_mods"				# модули работы с файлами конфигураций
path_content="modules/content_mods"				# модули работы со стартовым содержимым проектов

# к шаблонам

templ_cap_dev="templates/cap_dev"				# ЗАГЛУШКИ
templ_cap_prod="templates/cap_prod"				# 
templ_conf_bind="templates/conf_bind"			# КОНФИГУРАЦИОННЫЕ ФАЙЛЫ
templ_conf_nginx="templates/conf_nginx"			# 
templ_skel_back="templates/skel_back"			# ТИПОВОЕ СОДЕРЖАНИЕ ПАПОК
templ_skel_content="templates/skel_content"		# 
templ_skel_front="templates/skel_front"			# 
templ_skel_lay="templates/skel_lay"				# 

#----------------------------------
