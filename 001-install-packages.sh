set -e

echo "Install packages"
sudo apt update
sudo apt install python3-pip -y
sudo pip3 install RPi.GPIO

echo "Done."
