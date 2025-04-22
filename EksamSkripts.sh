#! /bin/bash
# Eksam 2020V opp 19
a=$(date -d $1 +%s)
b=$(date -d $2 +%s)

c=`expr $b - $a`
echo "$c"

# Opp 20
a=$(date -d $1 +%s)
b=$(date -d $2 +%s)

c=$(($b - $a))

d=$(date -d@$c -u +%H:%M:%S)
echo "$d"