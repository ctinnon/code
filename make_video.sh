#!/bin/bash

#Make folders
mkdir /mnt/sdb1/timelapse/$1/raw
#mkdir /mnt/sdb1/timelapse/$1/jpg
mkdir /mnt/sdb1/timelapse/$1/resized
mkdir /mnt/sdb1/timelapse/$1/cropped

#Move all raw to directory
#echo "Moving raw files to raw"
#mv *.CR2 ./raw

#echo "Moving into raw directory"
#cd /mnt/sdb1/timelapse/$1/raw

#Extract jpg from CR2
#exiv2 -ep3 *.CR2

#Move jpg to jpg folder
#mv *.jpg ../jpg

#Rename to standard img_0000 format
cd /mnt/sdb1/timelapse/$1/jpg
ls *.jpg | awk 'BEGIN{a=0}{printf "mv %s IMG_%04d.jpg\n", $0, a++}' | bash

echo "#####################"
echo "#  Resizing Images  #"
echo "#####################"
cd /mnt/sdb1/timelapse/$1/jpg
filelist=`ls | grep '.jpg'`
for image_file in $filelist
do
echo "Resizing file "$image_file
#convert $image_file -resize 1920x1280 /mnt/sdb1/timelapse/$1/resized/$image_file
done

echo "#####################"
echo "#  Cropping Images  #"
echo "#####################"
cd /mnt/sdb1/timelapse/$1/resized
filelist=`ls | grep '.jpg'`
for image_file in $filelist
do
echo "Cropping file "$image_file
convert $image_file -gravity $2 -crop 1920x1080+0+0 /mnt/sdb1/timelapse/$1/cropped/$image_file
done

echo "####################"
echo "#  Creating Video  #"
echo "####################"
cd /mnt/sdb1/timelapse/$1/cropped
ffmpeg -i IMG_%04d.jpg -c:v libx264 -preset slow -crf 10 -c:a copy output.mkv
