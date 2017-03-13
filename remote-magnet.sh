#!/bin/bash
test -z $1 && echo "need magnet link!
$0 <magnet link>" && exit -1
 
HOST=hostname
PORT=9092
USER=username
PASS=password
 
LINK="$1"
# set true if you want every torrent to be paused initially
#PAUSED="true"
PAUSED="false"
SESSID=$(curl --silent --anyauth --insecure --user $USER:$PASS "https://$HOST:$PORT/transmission/rpc" | sed 's/.*<code>//g;s/<\/code>.*//g')
curl --silent --anyauth --insecure --user $USER:$PASS --header "$SESSID" "https://$HOST:$PORT/transmission/rpc" -d "{\"method\":\"torrent-add\",\"arguments\":{\"paused\":${PAUSED},\"filename\":\"${LINK}\"}}"
