#!/bin/bash

# Array of jokes
jokes=(
    "Why don't scientists trust atoms? Because they make up everything!"
    "What do you call fake spaghetti? An impasta."
    "I told my wife she was drawing her eyebrows too high. She looked
surprised."
    "Why did the scarecrow win an award? Because he was outstanding in his
field!"
    "How does a penguin build its house? Igloos it together."
)

# Get the number of jokes
num_jokes=${#jokes[@]}

# Generate a random index
random_index=$(( RANDOM % num_jokes ))

# Print the selected joke
echo "${jokes[$random_index]}"
