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


# Eksam2019 H
#! /bin/bash

cd /home/group144/eksam2019H
rm -r -d adir bdir cdir
rm -r -f afil2 bfil1 bom bom2 cfil1 cfil2 col container
touch afil2 bfil1 bom bom2 cfil1 cfil2 col container
for i in {a..c}
do
mkdir $i"dir"
done

afil=$(find . -type f -name "a*")
mv $afil /home/group144/eksam2019H/adir

bfil=$(find . -type f -name "b*")
mv $bfil /home/group144/eksam2019H/bdir

cfil=$(find . -type f -name "c*")
mv $cfil /home/group144/eksam2019H/cdir


