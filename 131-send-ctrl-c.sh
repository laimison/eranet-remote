# https://www.freebsddiary.org/APC/usb_hid_usages.php
echo -en "\x1B\0\x06\0\0\0\0\0" > /dev/hidg0
sleep 0.1
echo -en "\0\0\0\0\0\0\0\0" > /dev/hidg0
