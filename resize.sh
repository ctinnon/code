#!/bin/bash

cd /mnt/sdb1/timelapse/sunset/r
filelist=`ls | grep '.jpg'`
for image_file in $filelist
do
echo "Converting file "$image_file
convert $image_file -gravity south -crop 1920x1080+0+0 /mnt/sdb1/timelapse/sunset/r2/$image_file
done
