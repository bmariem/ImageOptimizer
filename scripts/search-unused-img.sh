#!/bin/bash

assets_path=$1
images=$(find . -type f \( ! -path './.git/*' ! -path $assets_path -and \( -name '*.png' -or -name '*.jpg' -or -name '*.jpeg' -or -name '*.svg' -or -name '*.gif' \) \) -exec echo ''{}'' \;)

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

	used_count=$(grep -Rl --exclude-dir={.git, $assets_path} $name | wc -l)
	echo "$name,$used_count"
	if [ $used_count = "0" ]
	then
      echo "rm -f $image" >> ./delete_unused_images.sh
	fi

done
