#!/bin/bash

  open_firefox() {
      echo "Opening Firefox with fun pages..."
      firefox "https://www.youtube.com/watch?v=bPjZmQAvk_8&list=PLP7dQLdOcWqkGqBSNOuXTETUmp6jBEg0-&index=1&autoplay=1" "https://www.twitch.tv/zenzen77" "https://www.reddit.com" "https://candidate.webcruiter.com/nb-no/Account/SpaLogin?ReturnUrl=%2F" "https://www.finn.no/job/fulltime/search.html?location=0.20001&q=utvikler+sommerjobb&stored-id=74761418" "https://www.instagram.com" 2>/dev/null &
  }
  open_discord() {
    echo "Opening discord "
    discord 2>/dev/null &
  }

  main() {
    open_firefox
    open_discord

  }

  # Run the main function
  main