
if [ -n "$1" ] ; then

PNGNAME=`readlink -f "$1"`
echo
echo "Reading input file $PNGNAME "
echo

fi

cd "`dirname $0`"

DATETIME="`date +%Y-%m-%d-%H-%M-%S`"
HOSTNAME="`hostname`"
TITLE="$USER at `date` on $HOSTNAME"

POSTNAME="$DATETIME-$HOSTNAME-$USER"
DIRNAME="plated/source/blog/$POSTNAME"

mkdir $DIRNAME

if [ -n "$1" ] ; then

cp "$PNGNAME" $DIRNAME/printscreen.png

else

gnome-screenshot -f $DIRNAME/printscreen.png || import -window root $DIRNAME/printscreen.png

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
echo "}"                                  >>$DIRNAME/^.html
echo ""                                   >>$DIRNAME/^.html
echo "#^_blog_post_body form=markdown"    >>$DIRNAME/^.html
echo ""                                   >>$DIRNAME/^.html
echo "..."                                >>$DIRNAME/^.html
echo ""                                   >>$DIRNAME/^.html

echo
echo "Requesting post content SAVE AN EMPTY FILE TO CANCEL "
echo

gedit $DIRNAME/^.html || mousepad $DIRNAME/^.html

# delete the #^_blog_post_body line from file to undo posting of screenshot

if grep -q "#^_blog_post_body" "$DIRNAME/^.html"; then

echo
echo "Publishing updates"
echo

	git add $DIRNAME
	git commit -m"printscreen"
	git pull

#run using bash to make sure we have node setup OK?
	bash plated/publish
	
echo
echo "Tweeting"
echo
	./tweet.sh $POSTNAME

else

	rm -rf $DIRNAME

fi

