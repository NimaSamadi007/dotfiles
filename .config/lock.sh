#!/bin/bash

# i3lock blurred screen inspired by /u/patopop007 and the blog post
# http://plankenau.com/blog/post-10/gaussianlock

IMAGE=/tmp/screen.png
OUT_IMAGE=/tmp/i3lock.png
SCREENSHOT="scrot -o $IMAGE" # 0.46s

$SCREENSHOT
ffmpeg -hwaccel auto -y -i $IMAGE -i /home/nima/tmp/lock.png -filter_complex "boxblur=5:1,overlay=3*main_w/4-overlay_w/2:(main_h-overlay_h)/2" $OUT_IMAGE -loglevel quiet
i3lock -i $OUT_IMAGE

