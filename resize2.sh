#!/bin/bash
cd /mnt/sdb1/timelapse/firepit
filelist=`ls | grep '.JPG'`
for image_file in $filelist
do
echo "Taco Taco "$image_file
done
