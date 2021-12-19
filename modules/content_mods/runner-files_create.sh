#!/bin/bash

source variables-tmp.sh

cp -r $templ_skel_lay/gulpfile-build.js $gitlab_dev/$project_name/lay/gulpfile.js			# Копирование gulpfile.js
cp -r $templ_skel_lay/package.json $gitlab_dev/$project_name/lay/package.json				# Копирование package.json

cd $gitlab_dev/$project_name/lay/
npm install										# установка NPM-пакетов для сборки