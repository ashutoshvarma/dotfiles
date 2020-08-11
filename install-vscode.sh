#!/bin/bash

#PS4='$LINENO: '
#set -x

DEST=~/vscode
VERSION_FILE=${DEST}/.version
REMOTE_VERSION=

echo Visual Studio Code updater


LOCAL_VERSION="none" && [ -f $VERSION_FILE ] && LOCAL_VERSION=$(cat $VERSION_FILE)
echo -e "Local version\t: $LOCAL_VERSION"

#Check version on remote
#REMOTE_VERSION=1.36.0
REMOTE_VERSION=$(curl -s -L https://code.visualstudio.com/updates | grep -Po '(?<=strong\>Update )[^:]+' | grep -oP '[^</strong>]+' | tail -1)
echo -e "Remote version\t: $REMOTE_VERSION"

if [ "$REMOTE_VERSION" == "$LOCAL_VERSION" ]; then
  echo "No update available"
  exit
fi

read -sp "Enter to update, Ctrl-C to abort... " && echo

echo Downloading ...
TMPWORK=$(mktemp -d)
cd $TMPWORK
wget -q --show-progress https://update.code.visualstudio.com/${REMOTE_VERSION}/linux-deb-x64/stable -O code_${REMOTE_VERSION}_amd64.deb

echo Extracting ...
ar x code_${REMOTE_VERSION}_amd64.deb data.tar.xz

rm -rf $DEST
mkdir $DEST
bsdtar -xf data.tar.xz -C $DEST

#adjust path
sed -e "s%/usr/share/code/code%${DEST}/usr/share/code/code%" -e "s%Icon=com.visualstudio.code%Icon=${DEST}/usr/share/pixmaps/com.visualstudio.code.png%" ${DEST}/usr/share/applications/code.desktop > ~/.local/share/applications/code.desktop

#Store version
echo $REMOTE_VERSION > $VERSION_FILE

cd
rm -rf $TMPWORK
echo Done.

[ $(pgrep -c -f ${DEST}/usr/share/code/code) -gt 0 ] && echo "Restart Visual Studio Code to use the latest version."
