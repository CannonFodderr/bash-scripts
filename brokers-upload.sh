#!/bin/bash
read -r -p "File path to upload: " FILE_PATH
read -r -p "ENV (int (default) / stg / prd ): " SELECTED_ENV;

HOSTS_FOLDER="./hosts/brokers"
# Select hosts file to upload
HOSTS_FILE="$HOSTS_FOLDER/integration";
if [ "$SELECTED_ENV" == 'stg' ];then
    HOSTS_FILE="$HOSTS_FOLDER/staging";
elif [ "$SELECTED_ENV" == 'prd' ]; then
    HOSTS_FILE="$HOSTS_FOLDER/production";
fi

echo "SELECTED HOST FILE: $HOSTS_FILE"

while IFS= read -r host; do
  echo "UPLOADING: $FILE_PATH TO: $host:~"
  scp "$FILE_PATH" "$host:~"
done <$HOSTS_FILE