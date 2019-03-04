#!/bin/bash

# decimal and hexadecimal table - https://www.ibm.com/support/knowledgecenter/en/ssw_aix_71/com.ibm.aix.networkcomm/conversion_table.htm

print_help () {
echo "Video:
An example to send stream from 192.168.2.104 (video sender) to 192.168.2.100 (VLC receiver - possible public IP):
http://192.168.2.104/dev/info.cgi?action=streaminfo&udp=n&rtp=y&multicast=n&unicast=y&mcastaddr=192.168.2.100&port=5004
user: admin, password: 123456

See video -> open VLC app - open network stream
udp://@:5004

If you want to change the quality to SD, HD or Full HD:
http://192.168.2.104/dev/info.cgi?action=videoinfo&videoin_res=1920x1080_60P&videoin_frate=60&selvideoout_fhd=2&videoout_hd=2&videoout_fhd=2&selvideoout_hd=2&videoout_brate_fhd=15000&videoout_brate_hd=12000&videoout_brate_sd=1000
http://192.168.2.104/dev/info.cgi?action=videoinfo&videoin_res=1920x1080_60P&videoin_frate=60&selvideoout_fhd=1&videoout_hd=1&videoout_fhd=1&selvideoout_hd=1&videoout_brate_fhd=15000&videoout_brate_hd=12000&videoout_brate_sd=1000
http://192.168.2.104/dev/info.cgi?action=videoinfo&videoin_res=1920x1080_60P&videoin_frate=60&selvideoout_fhd=0&videoout_hd=0&videoout_fhd=0&selvideoout_hd=0&videoout_brate_fhd=15000&videoout_brate_hd=12000&videoout_brate_sd=1000

Keyboard:
left-ctrl left-shift left-alt left-meta    return enter esc backspace tab    f1 pgup pgdown delete    right left up down    numlock capslock scrolllock
space minus dash equal lbracket rbracket backslash hash semicolon quote backquote tilde comma period slash

Mouse:
lc rc drag su sd    u1 u2 u3 u4    d1 d2 d3 d4    r1 r2 r3 r4    l1 l2 l3 l4

Relay (power on for 1 second, power on for 30 seconds, turn on HDMI unit for 1 hour):
power1 power30 hdmi3600"
}

print_help

while true
do
  echo -n ': '
  read input

  case $input in
    help)
      print_help
    ;;

    exit)
      exit 0
    ;;

    quit)
      exit 0
    ;;

    lc)
      # Left click
      echo -ne "\x01\0\0\0" > /dev/hidg0
      echo -ne "\x0\x0\x0\x0" > /dev/hidg0
    ;;

    rc)
      # Right click
      echo -ne "\x02\0\0\0" > /dev/hidg0
      echo -ne "\x0\x0\x0\x0" > /dev/hidg0
    ;;

    drag)
      # Left click and do not release
      echo -ne "\x01\0\0\0" > /dev/hidg0
    ;;

    su)
      # Scroll up
      echo -ne '\x00\x0\x0\x01' > /dev/hidg0
    ;;
    sd)
      # Scroll down
      echo -ne '\x00\x0\x0\xff' > /dev/hidg0
    ;;

    u1)
      # Up 3x127
      echo -ne "\x0\x0\x`printf "%x\n" 129`\x0" > /dev/hidg0
      echo -ne "\x0\x0\x`printf "%x\n" 129`\x0" > /dev/hidg0
      echo -ne "\x0\x0\x`printf "%x\n" 129`\x0" > /dev/hidg0
    ;;

    u2)
      # Up 127
      echo -ne "\x0\x0\x`printf "%x\n" 129`\x0" > /dev/hidg0
    ;;

    u3)
      # Up 3x5
      echo -ne "\x0\x0\x`printf "%x\n" 251`\x0" > /dev/hidg0
      echo -ne "\x0\x0\x`printf "%x\n" 251`\x0" > /dev/hidg0
      echo -ne "\x0\x0\x`printf "%x\n" 251`\x0" > /dev/hidg0
    ;;

    u4)
      # Up 5
      echo -ne "\x0\x0\x`printf "%x\n" 251`\x0" > /dev/hidg0
    ;;

    l1)
      # Left 3x127
      echo -ne "\x0\x`printf "%x\n" 129`\x0\x0" > /dev/hidg0
      echo -ne "\x0\x`printf "%x\n" 129`\x0\x0" > /dev/hidg0
      echo -ne "\x0\x`printf "%x\n" 129`\x0\x0" > /dev/hidg0
    ;;

    l2)
      # Left 127
      echo -ne "\x0\x`printf "%x\n" 129`\x0\x0" > /dev/hidg0
    ;;

    l3)
      # Left 3x5
      echo -ne "\x0\x`printf "%x\n" 251`\x0\x0" > /dev/hidg0
      echo -ne "\x0\x`printf "%x\n" 251`\x0\x0" > /dev/hidg0
      echo -ne "\x0\x`printf "%x\n" 251`\x0\x0" > /dev/hidg0
    ;;

    l4)
      # Left 5
      echo -ne "\x0\x`printf "%x\n" 251`\x0\x0" > /dev/hidg0
    ;;

    d1)
      # Down 3x127
      echo -ne "\x0\x0\x`printf "%x\n" 127`\x0" > /dev/hidg0
      echo -ne "\x0\x0\x`printf "%x\n" 127`\x0" > /dev/hidg0
      echo -ne "\x0\x0\x`printf "%x\n" 127`\x0" > /dev/hidg0
    ;;

    d2)
      # Down 127
      echo -ne "\x0\x0\x`printf "%x\n" 127`\x0" > /dev/hidg0
    ;;

    d3)
      # Down 3x5
      echo -ne "\x0\x0\x`printf "%x\n" 4`\x0" > /dev/hidg0
      echo -ne "\x0\x0\x`printf "%x\n" 4`\x0" > /dev/hidg0
      echo -ne "\x0\x0\x`printf "%x\n" 4`\x0" > /dev/hidg0
    ;;

    d4)
      # Down 5
      echo -ne "\x0\x0\x`printf "%x\n" 4`\x0" > /dev/hidg0
    ;;

    r1)
      # Right 3x127
      echo -ne "\x0\x`printf "%x\n" 127`\x0\x0" > /dev/hidg0
      echo -ne "\x0\x`printf "%x\n" 127`\x0\x0" > /dev/hidg0
      echo -ne "\x0\x`printf "%x\n" 127`\x0\x0" > /dev/hidg0
    ;;

    r2)
      # Right 127
      echo -ne "\x0\x`printf "%x\n" 127`\x0\x0" > /dev/hidg0
    ;;

    r3)
      # Right 3x5
      echo -ne "\x0\x`printf "%x\n" 4`\x0\x0" > /dev/hidg0
      echo -ne "\x0\x`printf "%x\n" 4`\x0\x0" > /dev/hidg0
      echo -ne "\x0\x`printf "%x\n" 4`\x0\x0" > /dev/hidg0
    ;;

    r4)
      # Right 5
      echo -ne "\x0\x`printf "%x\n" 4`\x0\x0" > /dev/hidg0
    ;;

    "")
      # Empty
      echo "enter" | /home/pi/eranet-remote/hidgadget /dev/hidg1 keyboard
    ;;

    power1)
      # Power button for 1 sec
      /home/pi/eranet-remote/relay.py 1 1 &
    ;;

    power30)
      # Power button for 30 seconds
      /home/pi/eranet-remote/relay.py 1 30 &
    ;;

    hdmi3600)
      # HDMI turned on for 600 seconds
      /home/pi/eranet-remote/relay.py 2 3600 &
    ;;

    *)
      # Keyboard
      echo "${input}" | /home/pi/eranet-remote/hidgadget /dev/hidg1 keyboard
    ;;
  esac

  sleep 0.001
done
