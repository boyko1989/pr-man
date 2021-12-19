#!/bin/bash

source variables-tmp.sh
runn="$gitlab_dev/$project_name"

mkdir $runn
mkdir $runn/back
mkdir $runn/content
mkdir $runn/front
mkdir $runn/lay

chown -R $USER:$USER $runn
