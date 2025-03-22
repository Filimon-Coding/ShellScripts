#!/bin/bash

DISK="/dev/nvme1n1p2"
Mount_Path="/media/neov/NewDisk/"
FOLDER_PATH="$Mount_Path/OnedriveEverything/local-folder/Dokumenter/OsloMetITHele"

# Hvis mappen ikke finnes, kan det være disken ikke er aktivt montert ennå
if [ ! -d "$Mount_Path" ]; then
    echo "Prøver å montere disken først..."
    udisksctl mount -b "$DISK" 2>/dev/null
    sleep 2
fi
# sjekker vi om skolemappen finnes
if [ -d "$FOLDER_PATH" ]; then
    xdg-open "$FOLDER_PATH" &  # Opens the folder in the default file manager
    echo "Skole direktory mappe åpnes nå"
else
    echo "Feil: Mappen finnes ikke!"
    exit 1
fi
