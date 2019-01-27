#!/bin/bash

apt install usbutils libusb-dev -y

# sudo systemctl enable serial-getty@ttyAMA0.service
# sudo cp /lib/systemd/system/serial-getty@.service /etc/systemd/system/serial-getty@ttyAMA0.service
# sudo sed -i 's/agetty --keep-baud 115200/agetty -a pi --keep-baud 115200/g' /etc/systemd/system/serial-getty@ttyAMA0.service
# sudo systemctl daemon-reload

sudo sed -i 's/exit 0//g' /etc/rc.local
echo /home/pi/remote/hidenable.sh | sudo tee --append /etc/rc.local
echo exit 0 | sudo tee --append /etc/rc.local

gcc -o hidgadget hidgadget.c

sudo apt install vim git -y

sudo apt update
sudo apt install xfce4 xfce4-goodies tightvncserver -y

cp vlc.sh ~/Desktop/

sudo cp vncserver@.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable vncserver@1
sudo systemctl start vncserver@1
sudo systemctl status vncserver@1

echo "export VISUAL=/usr/bin/vi" | sudo tee --append /root/.bashrc
echo "export EDITOR=$VISUAL" | sudo tee --append /root/.bashrc

sudo crontab -l > /tmp/crontab
echo "*/1 * * * * /usr/bin/killall agetty" >> /tmp/crontab
echo "*/1 * * * * /usr/bin/who | grep pts && " >> /tmp/crontab
echo "*/1 * * * * /usr/bin/who | grep pts || " >> /tmp/crontab
sudo crontab /tmp/crontab

ln -sf ~/remote/vlc.sh ~/Desktop/vlc.sh

echo "set mouse=
syntax on
colorscheme desert" >> ~/.vimrc
