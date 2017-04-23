
cd "`dirname $0`"



DATETIME="`date +%Y-%m-%d-%H-%M-%S`"
HOSTNAME="`hostname`"
TITLE="$USER at `date` on $HOSTNAME"

POSTNAME="$DATETIME-$HOSTNAME-$USER"
DIRNAME="plated/source/blog/$POSTNAME"

mkdir $DIRNAME

gnome-screenshot -f $DIRNAME/printscreen.png || import -window root $DIRNAME/printscreen.png

convert $DIRNAME/printscreen.png -resize 256x256 $DIRNAME/printscreen.thumb.png
convert $DIRNAME/printscreen.png -resize 1x1 $DIRNAME/printscreen.pixel.png


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


gedit $DIRNAME/^.html || mousepad $DIRNAME/^.html

# delete the #^_blog_post_body line from file to undo posting of screenshot

if grep -q "#^_blog_post_body" "$DIRNAME/^.html"; then

	git add $DIRNAME
	git commit -m"printscreen"

#run using bash to make sure we have node setup OK?
	bash plated/publish

	python ./tweet.py $DIRNAME/printscreen.png "Work In Progress http://notshi.github.io/printscreen/blog/$POSTNAME/"

else

	rm -rf $DIRNAME

fi

