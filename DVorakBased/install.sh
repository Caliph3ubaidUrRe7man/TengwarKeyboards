
LAYOUTFILE="tengdvorak"
SHORTDESC="Tengwar"
DESCRIPTION="Tengwar Unicode Dvorak"
LANGUAGE="qya"

## This script must be run as root.
if [ "$UID" -ne 0 ]
then
  echo; echo "You are not root; please start this script with sudo."; echo
  exit 85
fi  

## Installation directory has been the same since at least Ubuntu 8.04.
## Check that it still exists. (If it does, I presume it's right.)
TARGETDIR="/usr/share/X11/xkb/symbols/"
if [ ! -d $TARGETDIR ]
then
   echo; echo "ERROR: Target directory $TARGETDIR does not exist. Sorry, I don't know what to do now. Exiting."; echo
   exit 1
fi

## Where should we store the entry for the layout?
RULESFILE="/usr/share/X11/xkb/rules/evdev.xml"
if [ ! -f $RULESFILE ]
then
   echo; echo "Warning: Could not find $RULESFILE."
   RULESFILE="/etc/X11/xkb/base.xml"
   if [ ! -f $RULESFILE ]
   then
      echo "ERROR: Couldn't find $RULESFILE either! Sorry, I don't know what to do now. Exiting."; echo
      exit 1
   else
      echo "I will use $RULESFILE instead."; echo
   fi
fi

## Installation depends on xmlstarlet
which xmlstarlet &>/dev/null
if [ $? -ne 0 ]
then
   apt-get install xmlstarlet
   if [ $? -ne 0 ]
   then
     echo; echo "ERROR: Could not find nor install xmlstarlet, which is needed. Exiting."; echo
     exit 1
   fi
fi

## Copy the layout file
cp $LAYOUTFILE $TARGETDIR
if [ $? -ne 0 ]
then
  echo; echo "ERROR: Could not copy $LAYOUTFILE to $TARGETDIR. Exiting."; echo
  exit 1
fi

## Create a backup of the rules file
cp $RULESFILE $RULESFILE~
if [ $? -ne 0 ]
then
  echo; echo "ERROR: Could not create backup of $RULESFILE. Exiting."; echo
  exit 1
fi

## Adding the layout to the list of installed layouts
ROT="/xkbConfigRegistry/layoutList/layout[last()]"
xmlstarlet ed -P \
 -d "/xkbConfigRegistry/layoutList/layout[configItem/name='$LAYOUTFILE']" \
 -s "/xkbConfigRegistry/layoutList" -t elem -n "layout" -v "
      " -i $ROT -t text -n "" -v "    " \
 -s $ROT -t elem -n "configItem" -v "
        " -s $ROT"/configItem" -t elem -n "name" -v "$LAYOUTFILE" \
 -s $ROT"/configItem" -t elem -n "shortDescription" -v "$SHORTDESC" \
 -s $ROT"/configItem" -t elem -n "description" -v "$DESCRIPTION" \
 -s $ROT"/configItem" -t elem -n "languageList" -v "" \
 -s $ROT"/configItem/languageList" -t elem -n "iso639Id" -v "$LANGUAGE" \
 -s $ROT -t elem -n "variantList" -v "" \
 -a $ROT"/configItem/name" -t text -n "" -v "
        " -a $ROT"/configItem/shortDescription" -t text -n "" -v "
        " -a $ROT"/configItem/description" -t text -n "" -v "
        " -a $ROT"/configItem/languageList" -t text -n "" -v "
      " -a $ROT"/configItem" -t text -n "" -v "
      " -a $ROT"/variantList" -t text -n "" -v "
    " -a $ROT -t text -n "" -v "
" $RULESFILE~ > $RULESFILE
if [ $? -ne 0 ]
then
  cp $RULESFILE~ $RULESFILE
  echo; echo "ERROR: Some error occured while editing $RULESFILE. Exiting."; echo
  exit 1
fi

## Generate uninstall script
echo "#!/bin/bash" > uninstall.sh
echo "sudo rm $TARGETDIR$LAYOUTFILE" >> uninstall.sh
echo "sudo mv $RULESFILE~ $RULESFILE" >> uninstall.sh
chmod +x uninstall.sh

## Success!
echo; echo "The file $LAYOUTFILE has been copied to $TARGETDIR, and $RULESFILE has been updated to reflect this. An uninstall script, uninstall.sh, has been generated."; echo

exit 0

