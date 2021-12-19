#!/bin/bash

source variables-tmp.sh

cp $templ_skel_lay/gulpfile-dev.js $path_dev/$project_name/lay/gulpfile.js		# Копирование gulpfile.js
cp $templ_skel_lay/.gitignore $path_dev/$project_name/lay/.gitignore			# Копирование .gitignore
cp $templ_skel_lay/package.json $path_dev/$project_name/lay/package.json		# Копирование package.json
cp -r $templ_skel_lay/'#src' $path_dev/$project_name/lay/'#src'					# Копирование стартового шаблона

# Копирование .gitlab-ci.yml

# sed -e 's/$project_name/'$project_name'/; s!/$project_name.!\/'$project_name'.!; s/\.$project_name./.'$project_name'./; s!/$project_name/!/'$project_name'/!; s!/$project_name/\#!/'$project_name'/\#!' $templ_skel_lay/.gitlab-ci.templ > $path_dev/$project_name/lay/.gitlab-ci.yml

sed -e 's!/home/gitlab-runner/projects/$project_name/lay/!/home/gitlab-runner/projects/'$project_name'/lay/!; s!$project_name!'$project_name'!; s!/$project_name/!/'$project_name'/!; s!/$project_name.!/'$project_name'.!' $templ_skel_lay/.gitlab-ci.templ > $path_dev/$project_name/lay/.gitlab-ci.yml

# 's!/$project_name.!/'$project_name'.!'

cd $path_dev/$project_name/lay/
npm install

# sed -e 's!$project_name!'$project_name'!; s!/$project_name/!/'$project_name'/!; s!/$project_name.!/'$project_name'.!' ~/projects/web/src/content/scripts/NG-DNS-new-project/templates/skel_lay/.gitlab-ci.templ > ~/projects/web/src/content/scripts/NG-DNS-new-project/debug/.gitlab-ci.yml

# sed -e 's!/home/gitlab-runner/projects/$project_name/lay/!/home/gitlab-runner/projects/'$project_name'/lay/!; s!$project_name!'$project_name'!; s!/$project_name/!/'$project_name'/!; s!/$project_name.!/'$project_name'.!' ~/projects/web/src/content/scripts/NG-DNS-new-project/templates/skel_lay/.gitlab-ci.templ > ~/projects/web/src/content/scripts/NG-DNS-new-project/debug/.gitlab-ci.yml