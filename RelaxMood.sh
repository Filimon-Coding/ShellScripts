#!/bin/bash

  open_firefox() {
      echo "Opening Firefox with fun pages..."
      firefox "https://www.youtube.com/watch?v=bPjZmQAvk_8&list=PLP7dQLdOcWqkGqBSNOuXTETUmp6jBEg0-&index=1&autoplay=1" "https://www.twitch.tv/zenzen77" 2>/dev/null &
  }
  open_discord() {
    echo "Opening discord "
    discord 2>/dev/null &
  }

  main() {
      open_discord
      open_firefox

  }

  # Run the main function
  main