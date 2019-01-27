#!/bin/bash

if echo $1 | grep -q '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]'
then
  ip_target=$1
  echo "You can watch video stream on $ip_target by opening VLC network stream from udp://@:5004 address"
else
  ip_target=`ip route get 1 | awk '{print $NF;exit}'`
  echo "As you didn't specify the IP address where the video stream is pointed to so it's fine to point this to Raspberry PI Zero, then you can watch it through vnc://${ip_target} port 5900-5905 by opening VLC and getting the network stream from udp://@:5004"
fi

echo "Target IP is $ip_target ... Will start required actions in 8 seconds ..."

sleep 8

ip_streamer=`sudo nmap -sS --open -p 9999 192.168.2.0/24 | grep -e '^Nmap scan report for' -e '^9999/tcp' | tr "\n" " " | grep ' open ' | awk '{print $5}' | grep [0-9]`

if echo $? | grep ^0
then
  echo "Enabling Unicast ..."
  curl "http://${ip_streamer}/dev/info.cgi?action=streaminfo&udp=n&rtp=y&multicast=n&unicast=y&mcastaddr=${ip_target}&port=5004"
fi
