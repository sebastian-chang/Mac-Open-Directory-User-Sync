#!/bin/sh

function onLogOut()
{
	touch /private/.sync/checkFile
	echo $USER > /private/.sync/checkFile
	chmod 777 /private/.sync/checkFile
exit
}

trap 'onLogOut' 1 2 9 15
while true; do
    sleep 86400 &
    wait $!
done