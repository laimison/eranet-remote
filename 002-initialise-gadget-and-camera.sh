set -e

if ! getconf LONG_BIT | grep -q 32; then echo Only 32 bit support, please reinstall your OS; exit 1; fi
if ! vcgencmd get_camera | grep detected=1; then echo No Pi Camera detected, please check if it is connected correctly; exit 1; fi

echo "Enable Gadget and Camera support"

# Allocate 96M of CMA heap for GPU
cat /boot/cmdline.txt | grep -q cma= || echo "cma=96M `cat /boot/cmdline.txt`" > /boot/cmdline.txt

# Enable legacy camera
cat /boot/config.txt | grep -q "^start_x=1" | tail -n 1 || echo "start_x=1" >> /boot/config.txt

# Allocate 128M for GPU
cat /boot/config.txt | grep -q "^gpu_mem=128" | tail -n 1 || echo "gpu_mem=128" >> /boot/config.txt

# Enable USB gadget mode and camera module
cat /boot/config.txt | grep -q "^dtoverlay=dwc2,tc358743" | tail -n 1 || echo "dtoverlay=dwc2,tc358743" >> /boot/config.txt

# Enable serial ports on Pi pins (RX and TX)
cat /boot/config.txt | grep -q "^enable_uart=1" | tail -n 1 || echo "enable_uart=1" >> /boot/config.txt

# Print files
cat /boot/cmdline.txt
sleep 1
echo '----'
cat /boot/config.txt
echo '----'

echo "If you never rebooted Raspberry Pi after running this script, you have to do so ..."

echo "Enable Gadget mode"
modprobe dwc2
dtoverlay dwc2

dtoverlay -l
lsmod | grep dwc2

echo "Done."
