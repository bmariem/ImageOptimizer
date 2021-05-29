#!/bin/bash

images=$(find . -type f \( ! -path './.git/*' ! -path 'add assets paths here' -and \( -name '*.png' -or -name '*.jpg' -or -name '*.jpeg' -or -name '*.svg' -or -name '*.gif' \) \) -exec echo ''{}'' \;)

image_count=${#images[@]}

echo "Found images: $image_count"
echo '' > ./delete_unused_images.sh

for image in ${images} 
do

	name=`basename -s .png $image`
	name=`basename -s .jpg $name`
	name=`basename -s .jpeg $name`
	name=`basename -s .svg $name`
	name=`basename -s .gif $name`
	name=`basename -s @2x $name`

	used_count=$(grep -Rl --exclude-dir={.git,.gems,_site} $name | wc -l)
	echo "$name,$used_count"
	if [ $used_count = "0" ]
	then
      echo "rm -f $image" >> ./delete_unused_images.sh
	fi

done