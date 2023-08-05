set -e

function no_signal_shot() {
  cp /root/eranet-remote/site/shot_no_signal.jpeg /root/eranet-remote/site/shot.jpeg
}

function no_signal_shot_and_exit() {
  no_signal_shot
  exit 0
}

trap no_signal_shot_and_exit SIGTERM
trap no_signal_shot_and_exit INT

DEVICE=`v4l2-ctl --list-devices | grep -A 100 'csi):' | grep '/dev/video' | head -n 1 | awk '{print $1}'`; echo $DEVICE
# DEVICE=/dev/video0

echo "If you are having issues with resolutions, please try to apply different index"

# It is also possible to experiment with resolutions on Linux GUI
# export DISPLAY=":0"
# xrandr -q
# xrandr --output HDMI-2 -s 640x480
# xrandr --output HDMI-2 --auto

for i in `seq 3600`
do
  if ps -ef | grep -v ' grep ' | grep -q http.server
  then
    index=3; echo "Using resolution: `v4l2-ctl --list-dv-timings -k -d $DEVICE | grep -E \"\s${index}\:\"`"; v4l2-ctl --set-dv-bt-timings index=${index} -d $DEVICE; ffmpeg -y -f video4linux2 -i $DEVICE -loop 1 -vframes 1 -framerate 1 -ss 0.5 -stimeout 15000 /root/eranet-remote/site/shot.jpeg
  else
    echo "No HTTP server is running"
    exit 0
  fi
done || true

no_signal_shot

echo "Done."
