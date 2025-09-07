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




 echo "Enter a number"
 read number
 if [ $number -gt 10 ]; then
   echo "The number is great than 10"
   elif [ $number -lt 10 ]; then
     echo "The number is less than 10"
     elif [ $number -eq 10 ]; then
     echo "The number is equal to 10"
     else
     echo "invaild innput"
     fi

     count=1
     while [ $count -le 5 ]; do
       echo "Count: $count"
       count=$((count + 1))
     done

