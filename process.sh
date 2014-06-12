#!/bin/sh

rm -rf component-*/*
rm -rf thumbnails/* 2> /dev/null

cp index.html.1 index.html

for COMPONENT in $(ls -l | egrep '^d' | grep 'component' | sed 's/.*component/component/')
do
  echo $COMPONENT
  curl http://mozilla-appmaker.github.io/$COMPONENT/component.html > $COMPONENT/component.html 2> /dev/null
  curl -f http://mozilla-appmaker.github.io/$COMPONENT/component.css > $COMPONENT/component.css 2> /dev/null
  mkdir thumbnails/$COMPONENT/
  curl -f http://mozilla-appmaker.github.io/$COMPONENT/thumbnail.png > thumbnails/$COMPONENT/thumbnail.png 2> /dev/null
  # curl http://mozilla-appmaker.github.io/$COMPONENT/thumbnail.png > thumbnails/$COMPONENT.png 2> /dev/null
  # sed "s/thumbnail\.png/$COMPONENT.png/" $COMPONENT/component.html > ./tmpfile.html
  # mv tmpfile.html $COMPONENT/component.html
  echo "<link rel=\"import\" href=\"$COMPONENT/component.html\">"  >> index.html
done

cat index.html.2 >> index.html

vulcanize index.html

mkdir -p ~/projects/mozilla-appmaker/appmaker/public/bundles/components
rm -rf ~/projects/mozilla-appmaker/appmaker/public/bundles/components/*
mv thumbnails/* ~/projects/mozilla-appmaker/appmaker/public/bundles/components/
cp vulcanized.html ~/projects/mozilla-appmaker/appmaker/public/bundles/components/mozilla-appmaker.html

for FILE_PATH in "component-camera-button/images/arrow-up.png" "component-camera-button/images/camera-asleep.png" "component-camera-button/images/folder-photo.png"
do
  # echo http://mozilla-appmaker.github.io/$FILE_PATH
  # echo ~/projects/mozilla-appmaker/appmaker/public/bundles/components/$FILE_PATH
  mkdir -p $(dirname ~/projects/mozilla-appmaker/appmaker/public/bundles/components/${FILE_PATH})
  curl http://mozilla-appmaker.github.io/$FILE_PATH > ~/projects/mozilla-appmaker/appmaker/public/bundles/components/$FILE_PATH 2> /dev/null
done
