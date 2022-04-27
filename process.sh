#!/bin/bash

for DIRNAME in plated/source/blog/*; do
  echo $DIRNAME
  convert $DIRNAME/printscreen.png -resize 256x256 $DIRNAME/printscreen.thumb.png
  convert $DIRNAME/printscreen.png -resize 1x1 $DIRNAME/printscreen.pixel.png
  convert $DIRNAME/printscreen.png -colors 8 -unique-colors -scale 1000%  $DIRNAME/printscreen.gradient.png
done
