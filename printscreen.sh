
cd "`dirname $0`"



DATETIME=`date +%Y-%m-%d-%H-%M-%S`
TITLE=`date`

DIRNAME="plated/source/blog/$DATETIME-$USER"

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
