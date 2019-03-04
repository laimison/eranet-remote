#!/bin/bash

sudo apt update
sudo apt install usbutils libusb-dev nmap vim git tcpdump ffmpeg apache -y

echo "set mouse=
syntax on
colorscheme desert" >> ~/.vimrc

sudo sed -i 's/exit 0//g' /etc/rc.local
echo /home/pi/eranet-remote/hidenable.sh | sudo tee --append /etc/rc.local
echo exit 0 | sudo tee --append /etc/rc.local

gcc -o hidgadget hidgadget.c

echo "export VISUAL=/usr/bin/vi" | sudo tee --append /root/.bashrc | tee --append ~/.bashrc
echo "export EDITOR=/usr/bin/vi" | sudo tee --append /root/.bashrc | tee --append ~/.bashrc

grep 'cd ~/eranet-remote && ./control.sh' ~/.bashrc || echo 'echo "cd ~/eranet-remote && ./control.sh"' >> ~/.bashrc

printf '' | sudo tee /etc/motd
