#! /usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import division  # python2 compatibility
from time import time

import math
import subprocess

def battery_color():
  color_good="#24708A"
  color_bad="#C6572F"
  color_degraded="#C6572F"
  color_charging="#24708A"
  #  Example acpi raw output:  "Battery 0: Discharging, 43%, 00:59:20 remaining"
  acpi_raw = subprocess.check_output(["acpi"], stderr=subprocess.STDOUT)
  acpi_unicode = acpi_raw.decode("UTF-8")

  #  Example list: ['Battery', '0:', 'Discharging', '43%', '00:59:20', 'remaining']
  acpi_list = acpi_unicode.split(' ')

  charging = True if acpi_list[2][:8] == "Charging" else False
  percent_charged = int(acpi_list[3][:-2])

  time_remaining = ' ' + acpi_list[4] if len(acpi_list) > 4 else ""

  battery_full = False

  if percent_charged < 10:
    full_text = color_bad
  if percent_charged < 30:
    full_text = color_degraded
  else:
      full_text = color_good

  return full_text


print(battery_color())
