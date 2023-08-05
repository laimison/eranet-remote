#!/usr/bin/python3

import RPi.GPIO as GPIO
import time

# Disable Warning
GPIO.setwarnings(False)

# Set the GPIO mode
GPIO.setmode(GPIO.BCM)

# Set the relay pin number
relay_pin = 2

# Set the relay pin as an output pin
GPIO.setup(relay_pin, GPIO.OUT)

GPIO.output(relay_pin, GPIO.HIGH)  # Turn ON the relay

# GPIO.output(relay_pin, GPIO.LOW)  # Turn OFF the relay

time.sleep(15)

# GPIO.output(relay_pin, GPIO.HIGH)  # Turn ON the relay

GPIO.cleanup()
