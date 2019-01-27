#!/bin/bash

~/eranet-remote/streamer.sh
vlc --width 1024 --height 768 udp://@:5004
~/eranet-remote/control.sh
