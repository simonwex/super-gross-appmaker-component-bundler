#!/bin/sh

rm -rf component-*/*

cp index.html.1 index.html

for COMPONENT in $(ls -l | egrep '^d' | grep 'component-' | sed 's/.*component/component/')
do
  echo $COMPONENT
  wget -O $COMPONENT.zip https://github.com/mozilla-appmaker/$COMPONENT/archive/gh-pages.zip
  rm -rf $COMPONENT
  unzip $COMPONENT.zip && mv $COMPONENT-gh-pages $COMPONENT
  rm $COMPONENT.zip
  echo "<link rel=\"import\" href=\"$COMPONENT/component.html\">"  >> index.html

  # Copy assets to bundles

  rm -rf $COMPONENT/conf
  rm -rf $COMPONENT/tools
  rm -rf $COMPONENT/test
  rm -rf $COMPONENT/template



  for ASSET_PATH in `ls -d $COMPONENT/*/`
  do
    mkdir -p ~/projects/mozilla-appmaker/appmaker/public/bundles/components/$ASSET_PATH
    cp -R $ASSET_PATH/* ~/projects/mozilla-appmaker/appmaker/public/bundles/components/$ASSET_PATH/
  done



  cp $COMPONENT/thumbnail.png ~/projects/mozilla-appmaker/appmaker/public/bundles/components/$COMPONENT/thumbnail.png
done


cat index.html.2 >> index.html

vulcanize index.html

mkdir -p ~/projects/mozilla-appmaker/appmaker/public/bundles/components

cp vulcanized.html ~/projects/mozilla-appmaker/appmaker/public/bundles/components/mozilla-appmaker.html

for FILE_PATH in "component-camera-button/images/arrow-up.png" "component-camera-button/images/camera-asleep.png" "component-camera-button/images/folder-photo.png"
do
  # echo http://mozilla-appmaker.github.io/$FILE_PATH
  # echo ~/projects/mozilla-appmaker/appmaker/public/bundles/components/$FILE_PATH
  mkdir -p $(dirname ~/projects/mozilla-appmaker/appmaker/public/bundles/components/${FILE_PATH})
  curl http://mozilla-appmaker.github.io/$FILE_PATH > ~/projects/mozilla-appmaker/appmaker/public/bundles/components/$FILE_PATH 2> /dev/null
done
