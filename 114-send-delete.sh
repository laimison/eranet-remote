# https://www.freebsddiary.org/APC/usb_hid_usages.php
timeout 1 echo -en "\0\0\x4C\0\0\0\0\0" > /dev/hidg0
sleep 0.1
timeout 1 echo -en "\0\0\0\0\0\0\0\0" > /dev/hidg0
