#!/bin/bash

while true
do
    java -Xmx3G -Xmn2G -jar forge-1.12.2-14.23.5.2838-universal.jar nogui
    echo "If you want to stop the server process now, press ctrl-c before it reboots"
    echo "rebooting in"
    for i in 5 4 3 2 1
    do
        echo "$i..."
        sleep 1
    done
    echo "rebooting"
done