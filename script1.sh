#!/bin/bash

# A simple script to print a message and display the current date.
echo "Hello, this is the new script1!"
echo "Today’s date is: $(date)"
echo "Today is nice day"
echo " Yeyy funker nå "

for i in 1 2 3 4 5;do
  echo "Number : $i"
  done

  echo "What is you neam"
  read name
  echo "hello, $name! Welcome to bash scripting"

  greet() {
    echo "Hello, $1!"
  }

  greet "Alice"
  greet "Bob"
