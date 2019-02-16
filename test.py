#!/usr/bin/python

import sys

channel = int(sys.argv[1])
time = int(sys.argv[2])

if channel == 1:
  channel = 1000

if channel == 2:
  channel = 2000

print channel
print time
