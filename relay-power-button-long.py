#!/usr/bin/python

import RPi.GPIO as GPIO
import time
import sys

GPIO.setmode(GPIO.BCM)

# GPIO.setmode(GPIO.BOARD)

pinList = [2, 3, 4, 17, 27, 22, 10, 9]

# mypin = int(sys.argv[1])
mypin = 2

GPIO.setup(mypin,GPIO.OUT)
GPIO.output(mypin, False)
time.sleep(20);
GPIO.output(mypin, True)
GPIO.cleanup()
