#!/bin/sh

# Expected invocation is
# entrypoint.sh token lock

TOKEN=$1
LOCKED=$2
VENDIR_FILE=$3

# Set the token in the GitHub URL 
git config --add --global url."https://oauth-token:${TOKEN}@github.com/".insteadOf "https://github.com/"
git config --add --global url."https://oauth-token:${TOKEN}@github.com/".insteadOf "git@github.com/"

if [ "$LOCKED" = "true" ];
then
  LOCK_OPTION="--locked"
else
  LOCK_OPTION=""
fi

vendir sync $LOCK_OPTION -f $VENDIR_FILE

