#!/bin/bash

source variables-tmp.sh

# index.html в корне dev-проекта

sed -e 's/$project_name/'$project_name'/; s/\/$project_name./\/'$project_name'./; s/\.$project_name./.'$project_name'./' $templ_cap_dev/dev-index.templ > $path_dev/$project_name/index.html

# gulpfile для DEV
cp $templ_skel_lay/gulpfile-dev.js $path_dev/$project_name/lay/gulpfile.js									

# папка стартового шаблона
cp -r $templ_skel_lay/\#src/ $path_dev/$project_name/lay/

# файл package.json
cp $templ_skel_lay/package.json $path_dev/$project_name/lay/

# HTML-заглушка
sed 's/$project_name/'$project_name'/' $templ_cap_dev/lay.dev-index.templ > $path_dev/$project_name/lay/index.html

# Остальные папки

sed 's/$project_name/'$project_name'/' $templ_cap_dev/front.dev-index.templ > $path_dev/$project_name/front/index.html
sed 's/$project_name/'$project_name'/' $templ_cap_dev/back.dev-index.templ > $path_dev/$project_name/back/index.html
sed 's/$project_name/'$project_name'/' $templ_cap_dev/content.dev-index.templ > $path_dev/$project_name/content/index.html

chown -R $USER:$USER $path_dev/$project_name