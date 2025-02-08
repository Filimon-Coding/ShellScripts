#!/bin/bash

FILE="/home/neov/Documents/sshData2500.txt"

if [ -f "$FILE" ];
then
  xdg-open "$FILE"
else
    echo "Filen ble ikke funnet: $FILE"
fi