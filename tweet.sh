#!/bin/bash

cd "`dirname $0`"

POSTNAME=$1
DIRNAME="plated/source/blog/$POSTNAME"

if [ -f "$DIRNAME/printscreen.png" ] ; then

	TEXT=`sed '1,/#^_blog_post_body form=markdown/d' $DIRNAME/^.html | sed -e ':a;N;$!ba;s/\n/ /g' | awk '{$1=$1};1' | head -c 100 `

	python3 ./tweet.py $DIRNAME/printscreen.png "${TEXT}... http://notshi.github.io/printscreen/blog/$POSTNAME/"

	echo  "TWEETED : ${TEXT}... http://notshi.github.io/printscreen/blog/$POSTNAME/"

fi

