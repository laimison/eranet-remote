#!/bin/bash

sudo apt update
sudo apt install usbutils libusb-dev nmap vim git xfce4 xfce4-goodies tightvncserver vlc -y

echo "set mouse=
syntax on
colorscheme desert" >> ~/.vimrc

# sudo systemctl enable serial-getty@ttyAMA0.service
# sudo cp /lib/systemd/system/serial-getty@.service /etc/systemd/system/serial-getty@ttyAMA0.service
# sudo sed -i 's/agetty --keep-baud 115200/agetty -a pi --keep-baud 115200/g' /etc/systemd/system/serial-getty@ttyAMA0.service
# sudo systemctl daemon-reload

sudo sed -i 's/exit 0//g' /etc/rc.local
echo /home/pi/eranet-remote/hidenable.sh | sudo tee --append /etc/rc.local
echo exit 0 | sudo tee --append /etc/rc.local

gcc -o hidgadget hidgadget.c

echo "export VISUAL=/usr/bin/vi" | sudo tee --append /root/.bashrc | tee --append ~/.bashrc
echo "export EDITOR=/usr/bin/vi" | sudo tee --append /root/.bashrc | tee --append ~/.bashrc

vncserver
vncserver -kill :1

sudo cp vncserver@.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable vncserver@1
sudo systemctl start vncserver@1
sudo systemctl status vncserver@1

ln -sf ~/eranet-remote/vlc.sh ~/Desktop/vlc.sh

# sudo crontab -l > /tmp/crontab.root
# echo "*/1 * * * * /usr/bin/killall agetty" >> /tmp/crontab.root
# sudo crontab /tmp/crontab.root

crontab -l > /tmp/crontab.pi
echo '*/3 * * * * $HOME/eranet-remote/quality.sh >> /tmp/quality.log 2>&1' >> /tmp/crontab.pi
crontab /tmp/crontab.pi

grep 'cd ~/eranet-remote && ./control.sh' ~/.bashrc || echo 'echo "cd ~/eranet-remote && ./control.sh"' >> ~/.bashrc
