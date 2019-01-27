# eraNET Remote

This is the solution to control computer remotely which includes keyboard, mouse and screen access.

## Prerequisites

### Equipment

* Lenkeng LKV373A V3.0 Sender [https://www.ebay.co.uk/itm/LKV373A-HDMI-Network-Extender-Transmitter-1080P-to-120M-Over-RJ45-Cat6-Cable-3D/263202502448?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2057872.m2749.l2649](https://www.ebay.co.uk/itm/LKV373A-HDMI-Network-Extender-Transmitter-1080P-to-120M-Over-RJ45-Cat6-Cable-3D/263202502448?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2057872.m2749.l2649)

* Raspberry Pi Zero W [https://www.ebay.co.uk/itm/NEW-Raspberry-Pi-Zero-Pi0-W-WiFi-Wireless-Bluetooh-1-Ghz-512MB-Micro-Computer-UK/132912804616?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2057872.m2749.l2649](https://www.ebay.co.uk/itm/NEW-Raspberry-Pi-Zero-Pi0-W-WiFi-Wireless-Bluetooh-1-Ghz-512MB-Micro-Computer-UK/132912804616?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2057872.m2749.l2649)

* 8 GB SD card

* 2 x USB to USB micro cables

* RJ45 cable

## Flashing

### Flash Lenkeng

* Download `IPTV_TX_PKG_v4_0_0_0_20160427.PKG` and `Encoder_20160407_0942.bin` images from [https://drive.google.com/drive/folders/0B3mWuDyxrXyKSTZZZlRESlpBZmM?usp=sharing](https://drive.google.com/drive/folders/0B3mWuDyxrXyKSTZZZlRESlpBZmM?usp=sharing)

* You can flash it through http://lenkeng-ip

* The username is admin and password 123456

* If you are not able to access, you can do a factory reset

```
nc lenkeng-ip 9999
list
factory_reset
```

* You can uncheck multicast through web GUI, to not flood all devices on your LAN with multicast

## Installation

### Install OS to Raspberry Pi Zero

The image used `2018-11-13-raspbian-stretch-lite.img`

Steps from Mac OS, but should be similar for any other OS

* Install OS to SD card (I used Etcher app)

* When the image is flashed successfully, modify Raspbian configuration files:

```
diskutil list
sudo diskutil mountDisk /dev/disk1

wifi_ssid=your_ssid
wifi_password=your_password

echo '
dtoverlay=dwc2
enable_uart=1' >> /Volumes/boot/config.txt

touch /Volumes/boot/ssh

echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid="$wifi_ssid"
    psk="$wifi_password"
    key_mgmt=WPA-PSK
}' > /Volumes/boot/wpa_supplicant.conf
```

* Insert SD to Raspberry Pi Zero

* `ssh pi@raspberry-ip` where username is pi and password is raspberry

* Run the scripts

```
cd ~
sudo apt update && sudo apt install git -y
git clone https://github.com/laimison/eranet-remote.git
cd eranet-remote
git config user.name laimison
```

For the first time if you are in the local network or accessed through VPN, you can run `./streamer.sh your-machine-local-ip` and then try to watch the stream by opening network stream on VLC on udp://@:5004

```
./streamer.sh
./install.sh
```

If you ran just `./streamer.sh`, the stream should be available through VNC at vnc://raspberry-ip:5901 , click VLC.sh on Desktop
