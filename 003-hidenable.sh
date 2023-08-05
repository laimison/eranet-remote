set -e

# Load module
modprobe libcomposite
modprobe usb_f_hid
lsmod | grep -e libcomposite -e usb_f_hid

# Create gadget
mkdir /sys/kernel/config/usb_gadget/mykeyboard
cd /sys/kernel/config/usb_gadget/mykeyboard

# Add basic information
echo 0x0100 > bcdDevice # Version 1.0.0
echo 0x0200 > bcdUSB # USB 2.0
echo 0x00 > bDeviceClass
echo 0x00 > bDeviceProtocol
echo 0x00 > bDeviceSubClass
echo 0x08 > bMaxPacketSize0
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x1d6b > idVendor # Linux Foundation

# Create English locale
mkdir strings/0x409

echo "My manufacturer" > strings/0x409/manufacturer
echo "My virtual keyboard" > strings/0x409/product
echo "0123456789" > strings/0x409/serialnumber

# Create HID function - keyboard
mkdir functions/hid.usb0

echo 1 > functions/hid.usb0/protocol
echo 8 > functions/hid.usb0/report_length # 8-byte reports
echo 1 > functions/hid.usb0/subclass

# Write report descriptor - keyboard
echo "05010906a101050719e029e71500250175019508810275089501810175019503050819012903910275019505910175089506150026ff00050719002aff008100c0" | xxd -r -ps > functions/hid.usb0/report_desc

# Create HID function - mouse
mkdir functions/hid.usb1

echo 2 > functions/hid.usb1/protocol
echo 4 > functions/hid.usb1/report_length
echo 1 > functions/hid.usb1/subclass

# Write report descriptor - mouse
echo -ne \\x05\\x01\\x09\\x02\\xA1\\x01\\x05\\x09\\x19\\x01\\x29\\x08\\x15\\x00\\x25\\x01\\x95\\x08\\x75\\x01\\x81\\x02\\x05\\x01\\x09\\x30\\x09\\x31\\x09\\x38\\x15\\x81\\x25\\x7F\\x75\\x08\\x95\\x03\\x81\\x06\\xC0 > functions/hid.usb1/report_desc

# Create configuration
mkdir configs/c.1
mkdir configs/c.1/strings/0x409

echo 0x80 > configs/c.1/bmAttributes
echo 200 > configs/c.1/MaxPower # 200 mA
echo "Example configuration" > configs/c.1/strings/0x409/configuration

# Link HID function to configuration - keyboard
ln -s functions/hid.usb0 configs/c.1/

# Link HID function to configuration - mouse
ln -s functions/hid.usb1 configs/c.1/

# Enable gadget
ls /sys/class/udc > UDC

sleep 5

ls -l /dev/hidg0 /dev/hidg1

echo "Done."
