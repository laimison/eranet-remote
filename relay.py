#!/usr/bin/python

import RPi.GPIO as GPIO
import time
import sys

GPIO.setmode(GPIO.BCM)
# GPIO.setmode(GPIO.BOARD)

channel = int(sys.argv[1])
seconds = int(sys.argv[2])

print "Turning on channel", channel, " for ", seconds, " second(s)."

ch = channel

if channel == 1:
  ch = 2

if channel == 2:
  ch = 3

if channel == 3:
  ch = 17

if channel == 4:
  ch = 27

GPIO.setup(ch,GPIO.OUT)
GPIO.output(ch, False)
time.sleep(seconds);
GPIO.output(ch, True)
GPIO.cleanup()
