# https://www.freebsddiary.org/APC/usb_hid_usages.php
echo -en "\0\0\x05\0\0\0\0\0" > /dev/hidg0
sleep 0.1
echo -en "\0\0\0\0\0\0\0\0" > /dev/hidg0
