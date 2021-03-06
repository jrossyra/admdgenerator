#!/bin/bash

DBPATH=$1
DBPORT=$2
NETDEVICE=$3

if [ -z "$NETDEVICE" ]
then
  NETDEVICE="ipogif0"
fi

# Parse the ip address of this node on Gemini
DBHOST=`ip addr show $NETDEVICE | grep -Eo '(addr:)?([0-9]*\.){3}[0-9]*'`

echo "$DBHOST" > $DBPATH/db.hostname

echo "Hopefully ulimit is 32k..."
ulimit -n

$ADMD_RUNTIME/launch_amongod.sh $DBPATH $DBPORT --launch 2> admd.mongodb.err 1> admd.mongodb.out
