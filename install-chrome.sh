#!/bin/bash
DEST=~/chrome
VERSION_FILE=${DEST}/.version
echo Google Chrome updater


LOCAL_VERSION="none" && [ -f $VERSION_FILE ] && LOCAL_VERSION=$(cat $VERSION_FILE)
echo -e "Local version\t: $LOCAL_VERSION"

# Check version on remote
REMOTE_VERSION=$(wget -q https://dl.google.com/linux/chrome/deb/dists/stable/main/binary-amd64/Packages.gz -O-| gunzip|sed -n '/Package: google-chrome-stable/ {n;p}'|cut -f2 -d\ )
echo -e "Remote version\t: $REMOTE_VERSION"

if [ "$REMOTE_VERSION" == "$LOCAL_VERSION" ]; then
  echo "No update available"
  exit
fi

read -sp "Enter to update, Ctrl-C to abort... " && echo

echo Downloading ...
TMPWORK=$(mktemp -d)
cd $TMPWORK
wget -q --show-progress https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${REMOTE_VERSION}_amd64.deb -O google-chrome-stable_current_amd64.deb

echo Extracting ...
ar x google-chrome-stable_current_amd64.deb data.tar.xz

rm -rf $DEST
mkdir $DEST
bsdtar -xf data.tar.xz -C $DEST

# adjust path
sed -e "s%/usr/bin/google-chrome-stable%${DEST}/opt/google/chrome/google-chrome%" ${DEST}/usr/share/applications/google-chrome.desktop > ~/.local/share/applications/google-chrome.desktop

# Store version
echo $REMOTE_VERSION > $VERSION_FILE

cd
rm -rf $TMPWORK
echo Done.
[ $(pgrep -c -f ${DEST}/opt/google/chrome/chrome) -gt 0 ] && echo "Restart Google Chrome to use the latest version."


