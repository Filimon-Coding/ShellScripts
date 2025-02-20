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
    "I told my computer I needed a break and now it won't stop sending me
     Kit-Kat ads."
     "Parallel lines have so much in common. It’s a shame they’ll never
      meet."
      "Did you hear about the mathematician who’s afraid of negative
       numbers? He will stop at nothing to avoid them!"
       "I used to play piano by ear, but now I use my hands."
       "Why don't skeletons fight each other? They don't have the guts."
       "What do you call fake spaghetti? An impasta."
       "I asked my date to meet me at the gym, but she never showed up. I
        guess the two of us aren’t going to work out."
        "Why was the math book sad? Because it had too many problems."
)

# Get the number of jokes
num_jokes=${#jokes[@]}

# Generate a random index
random_index=$(( RANDOM % num_jokes ))

# Print the selected joke
echo "${jokes[$random_index]}"
