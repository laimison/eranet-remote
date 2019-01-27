#!/bin/bash

ip_streamer=`sudo nmap -sS --open -p 9999 192.168.2.0/24 | grep -e '^Nmap scan report for' -e '^9999/tcp' | tr "\n" " " | grep ' open ' | awk '{print $5}' | grep [0-9]`

if echo $? | grep ^0
then
  # If someone logged in, increase video quality
  if who | grep pts
    echo "Switching to HD quality ..."
    curl "http://${ip_streamer}/dev/info.cgi?action=videoinfo&videoin_res=1920x1080_60P&videoin_frate=60&selvideoout_fhd=1&videoout_fhd=1&selvideoout_hd=1&videoout_hd=1&videoout_brate_fhd=15000&videoout_brate_hd=12000&videoout_brate_sd=1000"
  else
    echo "Switching to SD quality and low frame rate ..."
    curl "http://${ip_streamer}/dev/info.cgi?action=videoinfo&videoin_res=1920x1080_60P&videoin_frate=2&selvideoout_fhd=2&videoout_fhd=2&selvideoout_hd=2&videoout_hd=1&videoout_brate_fhd=15000&videoout_brate_hd=12000&videoout_brate_sd=1000"
  fi
fi
