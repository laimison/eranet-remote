#!/usr/bin/python

import RPi.GPIO as GPIO
import time
import sys

print "Usage is ./relay.py <channel> <seconds>"

GPIO.setmode(GPIO.BCM)
# GPIO.setmode(GPIO.BOARD)

channel = int(sys.argv[1])
seconds = int(sys.argv[2])

ch = channel

if channel == 1:
  ch = 2

if channel == 2:
  ch = 3

if channel == 3:
  ch = 17

if channel == 4:
  ch = 27

print channel
print seconds

GPIO.setup(ch,GPIO.OUT)
GPIO.output(ch, False)
time.sleep(seconds);
GPIO.output(ch, True)
GPIO.cleanup()
