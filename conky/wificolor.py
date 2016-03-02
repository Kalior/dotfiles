#! /usr/bin/python

# -*- coding: utf-8 -*-
from __future__ import division  # python2 compatibility
from time import time

import math
import subprocess

interface = "wlp58s0"
color_bad = "#C6572F"
color_good = "#24708A"
color_degraded = "#C6572F"

def wifi_color():
  full_text = ""
  #  Example ip dev [interface] link:
      #Connected to d0:c7:89:25:81:21 (on wlo1)
      #SSID: eduroam
      #freq: 2412
      #RX: 8833778 bytes (41357 packets)
      #TX: 2195457 bytes (10139 packets)
      #signal: -74 dBm
      #tx bitrate: 6.0 MBit/s

      #bss flags:  short-preamble short-slot-time
      #dtim period:    1
      #beacon int: 102

  ip_raw = subprocess.check_output(["iw", "dev", interface, "link"], stderr=subprocess.STDOUT)
  ip_unicode = ip_raw.decode("UTF-8")

  if ip_unicode == "Not connected.\n":
    full_text = color_bad
  else:
    #  Example list: [\tConnected to d0:c7:89:25:81:21 (on wlo1), \tSSID: eduroam, \tfreq: 2412, \tRX: 8833778 bytes (41357 packets) etc.]
    ip_list = ip_unicode.split('\n')

    ssid = ip_list[1].split(' ')[1]

    signal_strength = int(ip_list[5].split(' ')[1])

    signal_block = ""
    if signal_strength > -50:
        full_text = color_good
    elif signal_strength > -55:
        full_text = color_good
    elif signal_strength > -60:
        full_text = color_degraded
    elif signal_strength > -70:
        full_text = color_bad
    else:
        full_text = color_bad

  return full_text


print(wifi_color())
