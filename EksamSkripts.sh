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

# Opp 19
a=$(date -d $1 +%s)
b=$(date -d $2 +%s)

c=$(($b - $a))

d=$(date -d@$c -u +%H:%M:%S)
echo "$d"


# Dockerfile for stanard ubuntu with apache2 in background husk .
FROM ubuntu:latest

RUN apt-get update
RUN apt-get install nano -y
RUN apt-get install apache2 -y

COPY index.html /var/www/html

CMD ["apachectl", "-D", "FOREGROUND"]

