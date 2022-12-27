#!/bin/bash

# SELECT HOSTS FOLDER
FOLDERS=$(ls -d ./hosts/*)
echo "$FOLDERS"
COLUMNS=0
echo "SELECT HOSTS FOLDER"
select folder in $FOLDERS; do test -n "$folder" && break; echo ">>> Invalid Selection"; done
echo "Selected folder: $folder"

#SELECT A FILE PATH IN HOSTS FOLDER
FILES=$(ls -p "$folder"/*)
echo "SELECT HOSTS FILE:"
COLUMNS=0
select hostsfile in $FILES; do test -n "$folder" && break; echo ">>> Invalid Selection"; done
echo "Selected file:  $hostsfile"

# UPLOAD FILE PATH
read -r -p "FILE PATH TO UPLOAD: " FILE_PATH;

if [ "$FILE_PATH" == "" ]; then
  FILE_PATH="./test/test.txt";
fi

# SET DEFAULT HOST PATH
read -r -p "SET HOSTS PATH TO UPLOAD TO (default: ~): " DEFAULT_HOST_PATH
if [ "$DEFAULT_HOST_PATH" == "" ];then
    DEFAULT_HOST_PATH="~"
fi

# UPLOAD TO EACH HOST
while IFS= read -r host; do
  echo "UPLOADING: $FILE_PATH TO: $host:$DEFAULT_HOST_PATH"
  scp "$FILE_PATH" "$host:$DEFAULT_HOST_PATH"
done <"$hostsfile"