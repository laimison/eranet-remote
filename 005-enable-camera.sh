set -e

modprobe tc358743
dtoverlay tc358743

dtoverlay -l
lsmod | grep tc358743
echo "Done."
