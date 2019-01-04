#!/bin/bash




# Translations
# generate pot file
echo "update translations"
find ../qml/* -iname "*.qml" | xargs xgettext --from-code utf-8 -C --qt --keyword=tr -o ../click/textsecure.nanuc.pot
find ../po/* -exec msgmerge --update {} ../click/textsecure.nanuc.pot \;
rm ../po/*~~

# mkdir -p ../build/tmp/qml
# cp -a ../qml/phoneui ../build/tmp/qml
# cp -a ../docs/CHANGELOG.md ../build/tmp
cp -a ../click/* ../build/tmp
# cp -a ../lib ../build/tmp
# if [ $mode = "dev" ];then
# 	#copy config.yml or rootCA.pem
# 	cp -a dev/* build/
# fi

# Build and include translations
for po in ../po/*.po; do
	loc=$(echo $(basename $po)|cut -d'.' -f1)
	dir=../build/tmp/share/locale/$loc/LC_MESSAGES
	mkdir -p $dir
	msgfmt $po -o $dir/textsecure.nanuc.mo
done
