#!/bin/bash
read -r -p "File path to upload: " FILE_PATH;

if [ "$FILE_PATH" == "" ]; then
  FILE_PATH="./uploads/test.txt";
fi

read -r -p "ENV (int (default) / stg / prd ): " SELECTED_ENV;

HOSTS_FOLDER="./hosts/api"
# Select hosts file to upload
HOSTS_FILE="$HOSTS_FOLDER/integration";
if [ "$SELECTED_ENV" == 'stg' ];then
    HOSTS_FILE="$HOSTS_FOLDER/staging";
elif [ "$SELECTED_ENV" == 'prd' ]; then
    HOSTS_FILE="$HOSTS_FOLDER/production";
fi

echo "SELECTED HOST FILE: $HOSTS_FILE";

read -r -p "HOST PATH (default: ~/apps/roboteam-server)" HOST_PATH;

if [ "$HOST_PATH" == "" ]; then
  HOST_PATH="$HOME/apps/roboteam-server";
fi

# Read one line at the time and exectues the command
while IFS= read -r host; do
  scp "$FILE_PATH" "$host:~/apps/roboteam-server"
done <$HOSTS_FILE;