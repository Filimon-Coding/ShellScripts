#!/bin/bash

# Directories
ONEDRIVE_REMOTE="onedrive-skole-sin:/"  # Replace with your existing remote name
LOCAL_DIR=~/school-files                # Your Linux directory for school files

# Sync from Linux to OneDrive
echo "Syncing from Linux folder to OneDrive..."
# rclone sync "$LOCAL_DIR" "$ONEDRIVE_REMOTE" \
    --progress \
    --max-age 1m \
    --size-only \
    --retries 3 \
    --ignore-errors \
    --log-file ~/rclone-push.log \
    --log-level INFO

if [ $? -eq 0 ]; then
    echo "Push completed successfully."
else
    echo "Push failed. Check ~/rclone-push.log for details."
fi
