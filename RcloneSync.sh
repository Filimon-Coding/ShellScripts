#!/bin/bash

# Function to sync from OneDrive to local directory
sync_from_onedrive() {
    echo "Starting synchronization from OneDrive to local folder..."
    rclone sync onedrive-skole-sin:/ ~/local-folder \
        --progress \
        --create-empty-src-dirs \
        --include "**" \
        --exclude "Thumbs.db" \
        --exclude "desktop.ini" \
        --exclude ".DS_Store"

    if [ $? -eq 0 ]; then
        echo "Synchronization from OneDrive to local folder completed successfully."
    else
        echo "Synchronization failed. Please check the logs."
    fi
}

# Function to sync from local directory to OneDrive
sync_to_onedrive() {
    echo "Starting synchronization from local folder to OneDrive..."
    rclone sync ~/local-folder onedrive-skole-sin:/ \
        --progress \
        --create-empty-src-dirs \
        --include "**" \
        --exclude "Thumbs.db" \
        --exclude "desktop.ini" \
        --exclude ".DS_Store"

    if [ $? -eq 0 ]; then
        echo "Synchronization from local folder to OneDrive completed successfully."
    else
        echo "Synchronization failed. Please check the logs."
    fi
}

# Main menu
main_menu() {
    echo "Choose a synchronization operation:"
    echo "1) Sync from OneDrive to local folder"
    echo "2) Sync from local folder to OneDrive"
    echo -n "Enter your choice (1 or 2): "
    read choice

    case $choice in
        1)
            sync_from_onedrive
            ;;
        2)
            sync_to_onedrive
            ;;
        *)
            echo "Invalid choice. Exiting."
            ;;
    esac
}

# Run the main menu
main_menu
