#!/bin/bash

DATETIME="`date +%Y-%m-%d-%H-%M-%S`"

if [ -n "$1" ] ; then

INPUT_FILENAME=`readlink -f "$1"`
echo
echo "Reading input file $INPUT_FILENAME "
echo

DATETIME="`date -r\"$INPUT_FILENAME\" +%Y-%m-%d-%H-%M-%S`"

fi

cd "`dirname $0`"

HOSTNAME="`hostname`"
TITLE="$USER at `date` on $HOSTNAME"

POSTNAME="$DATETIME-$HOSTNAME-$USER"
DIRNAME="plated/source/blog/$POSTNAME"
VIDEO=false

mkdir $DIRNAME

if [ -n "$1" ] ; then

if [ "${INPUT_FILENAME: -4}" == ".mp4" ] ; then

echo " Converting video to PNG "

VIDEO=true

cp "$INPUT_FILENAME" $DIRNAME/printscreen.mp4
# grab first
ffmpeg -i $DIRNAME/printscreen.mp4 -frames:v 1 $DIRNAME/printscreen.png

else

echo " Copying PNG "

cp "$INPUT_FILENAME" $DIRNAME/printscreen.png

fi

else

echo " Must provide png screenshot filename to publish "

exit 

fi


convert $DIRNAME/printscreen.png -resize 256x256 $DIRNAME/printscreen.thumb.png
convert $DIRNAME/printscreen.png -resize 1x1 $DIRNAME/printscreen.pixel.png
convert $DIRNAME/printscreen.png -colors 8 -unique-colors -scale 1000%  $DIRNAME/printscreen.gradient.png


echo ""                                    >$DIRNAME/^.html
echo "#^_blog_post_json"                  >>$DIRNAME/^.html
echo ""                                   >>$DIRNAME/^.html
echo "{"                                  >>$DIRNAME/^.html
echo "	\"title\":\"$TITLE\","            >>$DIRNAME/^.html
echo "	\"author\":\"$USER\","            >>$DIRNAME/^.html
echo "	\"video\":$VIDEO,"                >>$DIRNAME/^.html
echo "}"                                  >>$DIRNAME/^.html
echo ""                                   >>$DIRNAME/^.html
echo "#^_blog_post_body form=markdown"    >>$DIRNAME/^.html
echo ""                                   >>$DIRNAME/^.html
echo "..."                                >>$DIRNAME/^.html
echo ""                                   >>$DIRNAME/^.html

echo
echo "Requesting post content "
echo
echo "SAVE AN EMPTY FILE TO CANCEL"
echo

kate $DIRNAME/^.html || gedit $DIRNAME/^.html || mousepad $DIRNAME/^.html 

# delete the #^_blog_post_body line from file to undo posting of screenshot

if grep -q "#^_blog_post_body" "$DIRNAME/^.html"; then

echo
echo "Publishing updates"
echo

	git add $DIRNAME
	git commit -m"printscreen"
	git pull
	git push

echo
echo "Tweeting"
echo
	./tweet.sh $POSTNAME

else

echo
echo "CANCELED"
echo
echo "Removing post"
echo

	rm -rf $DIRNAME

echo 5 ; sleep 1
echo 4 ; sleep 1
echo 3 ; sleep 1
echo 2 ; sleep 1
echo 1 ; sleep 1

fi

