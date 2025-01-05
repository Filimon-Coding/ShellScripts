#!/bin/bash

# SkoleMood: A script to set up your school environment

# Function to open Firefox with multiple tabs
open_firefox() {
    echo "Opening Firefox with school-related tabs..."
    firefox https://oslomet.instructure.com/ https://chat.openai.com/ https://github.com/Filimon-Coding 2>/dev/null &
}

# Function to open IntelliJ IDEA
open_intellij() {
    echo "Opening IntelliJ IDEA..."
    idea 2>/dev/null &
}

# Function to open the file explorer in a specific folder
open_file_explorer() {
    echo "Opening File Explorer at /home/neo/local-folder/Dokumenter..."
    nautilus /home/neo/local-folder/Dokumenter 2>/dev/null &
}

# Main function to call the above setup
main() {
    open_firefox
    open_intellij
    open_file_explorer
}

# Run the main function
main
