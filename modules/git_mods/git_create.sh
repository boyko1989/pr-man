#!/bin/bash

source /home/p_boyko/projects/web/src/content/scripts/NG-DNS-new-project/variables-tmp.sh

git init
git add -A
git commit -m "INIT"

git remote add origin git@gitlab.com:boyko1989/$project_name-$1.git
git push origin master
