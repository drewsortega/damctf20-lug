#!/bin/bash

# create archive
tar -cxzf important docs

# copy the archive to our 'usb' directory
mkdir usb/Documents
mkdir usb/Documents/other
mkdir jsb/Documents/jfobb
cp important usb/Documents/jfobb/important

# create the image from the usb folder
mksquashfs ./usb ./usb.img

# create loop device with image
losetup /dev/loop2 ./usb.img
