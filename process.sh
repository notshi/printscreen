for DIRNAME in plated/source/blog/*; do
  convert $DIRNAME/printscreen.png -colors 8 -unique-colors -scale 1000%  $DIRNAME/printscreen.gradient.png
done
