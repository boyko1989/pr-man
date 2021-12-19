#!/bin/bash

source variables-tmp.sh
dev="$path_dev/$project_name"

mkdir $dev
mkdir $dev/back
mkdir $dev/content
mkdir $dev/front
mkdir $dev/lay

chown -R $USER:$USER $dev
