# https://www.freebsddiary.org/APC/usb_hid_usages.php
echo -ne '\x04\x01\x00\x00\x00\x00\x00\x00' > /dev/hidg0
sleep 0.3
echo -en "\x04\x01\x3c\0\0\0\0\0" > /dev/hidg0
sleep 0.3
echo -en "\0\0\0\0\0\0\0\0" > /dev/hidg0
