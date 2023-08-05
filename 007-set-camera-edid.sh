set -e

DEVICE=`v4l2-ctl --list-devices | grep -A 100 'csi):' | grep '/dev/video' | head -n 1 | awk '{print $1}'`

echo '00ffffffffffff005262888800888888
1c150103800000780aEE91A3544C9926
0F505400000001010101010101010101
010101010101011d007251d01e206e28
5500c48e2100001e8c0ad08a20e02d10
103e9600138e2100001e000000fc0054
6f73686962612d4832430a20000000FD
003b3d0f2e0f1e0a2020202020200100
020321434e041303021211012021a23c
3d3e1f2309070766030c00300080E300
7F8c0ad08a20e02d10103e9600c48e21
0000188c0ad08a20e02d10103e960013
8e210000188c0aa01451f01600267c43
00138e21000098000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000' > /tmp/tc358743_official.edid

echo '00ffffffffffff005262888800888888
1c150103800000780aEE91A3544C9926
0F505400000001010101010101010101
010101010101011d007251d01e206e28
5500c48e2100001e8c0ad08a20e02d10
103e9600138e2100001e000000fc0054
6f73686962612d4832430a20000000FD
003b3d0f2e0f9e0a2020202020200100
020321434e841303021211012021223c
3d3e1f2309070766030c00300080E300
7F8c0ad08a20e02d10103e9600c48e21
0000188c0ad08a20e02d10103e960013
8e210000188c0aa01451f01600267c43
00138e21000098000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000' > /tmp/tc358743_custom.edid

echo '00ffffffffffff005262888800888888
1c150103800000780aEE91A3544C9926
0F505400000001010101010101010101
010101010101011d007251d01e206e28
5500c48e2100001e8c0ad08a20e02d10
103e9600138e2100001e000000fc0054
6f73686962612d4832430a20000000FD
003b3d0f2e0f9e0a2020202020200100
020321434e841303021211012021223c
3d3e1f2309070766030c00300080E300
7F8c0ad08a20e02d10103e9600c48e21' > /tmp/tc358743_custom_2.edid
	
v4l2-ctl --set-edid=file=/tmp/tc358743_official.edid --fix-edid-checksums -d $DEVICE
# v4l2-ctl --set-edid=file=tc358743_custom.edid --fix-edid-checksums
# v4l2-ctl --query-dv-timings
# v4l2-ctl --list-devices
# v4l2-ctl -V

echo "If you are having issues with resolutions, please try to apply another edid file"

echo "Done."