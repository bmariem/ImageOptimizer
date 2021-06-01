#!/bin/bash

assets_path=$1

images=$(find . -type f \( ! -path './.git/*' ! -path $assets_path -and \( -name '*.png' -or -name '*.jpg' -or -name '*.jpeg' \) \) -exec echo ''{}'' \;)

image_count=${#images[@]}

echo "Found images: $image_count"
echo '' > ./convert_images.sh

for image in ${images} 
do

	name=`basename -s .png $image`
	name=`basename -s .jpg $name`
	name=`basename -s .jpeg $name`
	dir=`dirname $image`

	echo "cwebp '$image' -o '$dir/$name.webp'" >> ./convert_images.sh
	echo "rm -f '$image'" >> ./convert_images.sh

done

images=$(find . -type f \( ! -path './.git/*' ! -path $assets_path -and \( -name '*.gif' \) \) -exec echo ''{}'' \;)

image_count=${#images[@]}

echo "Found images: $image_count"
echo '' > ./convert_images_gif.sh

for image in ${images} 
do

	name=`basename -s .gif $image`
	dir=`dirname $image`

	echo "ffmpeg -i '$image' -c vp9 -b:v 0 -crf 41 '$dir/$name.webm'" >> ./convert_images_gif.sh 
	echo "rm -f '$image'" >> ./convert_images_gif.sh

done
