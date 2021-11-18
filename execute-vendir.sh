#!/bin/bash -ex

VENDIR_URL=$1
TOKEN=$2
LOCKED=$3
VENDIR_FILE=$4
WORKING_DIR=$5
TARGET_DIR=$6

cd $WORKING_DIR

# Download `vendir` binary
echo "Downloading vendir from: $VENDIR_URL"
wget --quiet $VENDIR_URL -O vendir
chmod +x vendir

# Set the token in the GitHub URL 
git config --add --global url."https://oauth-token:${TOKEN}@github.com/".insteadOf "https://github.com/"
git config --add --global url."https://oauth-token:${TOKEN}@github.com/".insteadOf "git@github.com:"

cat ~/.gitconfig

# Execute vendir with options
if [ "$LOCKED" = "true" ];
then
  LOCK_OPTION="--locked"
else
  LOCK_OPTION=""
fi

if [ -z "$TARGET_DIR" ];
then
  TARGET_OPTION=""
else
  TARGET_OPTION="--chdir $TARGET_DIR"
fi

VENDIR_GITHUB_API_TOKEN=$TOKEN ./vendir sync $LOCK_OPTION $TARGET_OPTION -f $VENDIR_FILE 

git config --unset-all --global url."https://oauth-token:${TOKEN}@github.com/".insteadof
cat ~/.gitconfig
