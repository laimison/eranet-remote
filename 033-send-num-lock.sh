# https://www.freebsddiary.org/APC/usb_hid_usages.php
echo -en "\0\0\x53\0\0\0\0\0" > /dev/hidg0
sleep 1
echo -en "\0\0\0\0\0\0\0\0" > /dev/hidg0