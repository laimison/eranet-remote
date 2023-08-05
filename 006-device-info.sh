DEVICE=`v4l2-ctl --list-devices | grep -A 100 'csi):' | grep '/dev/video' | head -n 1 | awk '{print $1}'`
v4l2-ctl --all -d $DEVICE
v4l2-ctl -V
v4l2-ctl --list-dv-timings -k -d $DEVICE
v4l2-ctl --list-devices
