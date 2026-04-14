#!/bin/bash

# First argument = commit message
message="$1"

# Shift removes the first argument so $@ now holds file names
shift

# If files are passed → add only those
if [ "$#" -gt 0 ]; then
    git add "$@"
else
    git add .
fi

git commit -m "$message"
git push origin main && git push gitlab main

echo "Committed with message: $message"
