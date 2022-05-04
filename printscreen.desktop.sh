#!/bin/bash

DIRNAME=`dirname $0`
export DIRNAME=`readlink -f $DIRNAME`

cd $DIRNAME

mkdir -p ~/.local/share/applications
envsubst <printscreen.desktop >~/.local/share/applications/printscreen.desktop

echo
echo " CREATING DESKTOP ENTRY for printscreen "
echo
cat ~/.local/share/applications/printscreen.desktop

update-desktop-database ~/.local/share/applications/


