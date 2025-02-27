#!/bin/bash

FOLDER_PATH="/media/neov/NewDisk/OnedriveEverything/local-folder/Dokumenter/OsloMetITHele"

if [ -d "$FOLDER_PATH" ]; then
    xdg-open "$FOLDER_PATH" &  # Opens the folder in the default file manager
    echo "Skole direktory mappe åpnes nå"
else
    echo "Feil: Mappen finnes ikke!"
    exit 1
fi
