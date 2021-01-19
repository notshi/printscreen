

DIRNAME=`dirname $0`
export DIRNAME=`readlink -f $DIRNAME`

cd $DIRNAME

envsubst <printscreen.desktop >~/.local/share/applications/printscreen.desktop

echo
echo " CREATING DESKTOP ENTRY for printscreen "
echo
cat ~/.local/share/applications/printscreen.desktop

update-desktop-database ~/.local/share/applications/


