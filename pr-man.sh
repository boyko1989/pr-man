#!/bin/bash

# Требование SUDO
if [ "$(id -u)" != 0 ]
then
	echo "В доступе отказано! Требуются административные права." >&2
	exit 1
fi

# Определяем задание: 

task=$1 
project_name=$2 

# Опредляем все переменные для проекта
source correct-vars.sh

if [[ "$task" == "cr" ]]
then       
    source tasks/create.sh

elif [[ "$task" == "del" ]]
then
    source tasks/delete.sh
else
    echo "Не опознано задание - $task"
fi
