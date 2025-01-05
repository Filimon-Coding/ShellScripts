/* */

#!/bin/bash
# Directories
ONEDRIVE_REMOTE="onedrive-skole-sin:/"  # Replace with your existing remote name
LOCAL_DIR=~/school-files                # Your Linux directory for school files

# Sync from OneDrive to Linux
echo "Syncing from OneDrive to Linux folder..."
#rclone sync "$ONEDRIVE_REMOTE" "$LOCAL_DIR" --progress --use-server-modtime --log-file ~/rclone-sync.log --log-level INFO
if [ $? -eq 0 ]; then
    echo "Sync completed successfully."
else
    echo "Sync failed. Check ~/rclone-sync.log for details."
fi
