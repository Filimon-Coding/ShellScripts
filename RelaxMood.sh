#!/bin/bash

open_firefox() {
    echo "Opening Firefox with school-related tabs..."
    firefox https://youtube.com 2>/dev/null &
}
main() {
    open_firefox
}

# Run the main function
main