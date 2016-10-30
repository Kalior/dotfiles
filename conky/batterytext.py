#! /usr/bin/python3

from __future__ import division  # python2 compatibility
from time import time

import math
import subprocess



def battery_text():
  #  Example acpi raw output:  "Battery 0: Discharging, 43%, 00:59:20 remaining"
  acpi_raw = subprocess.check_output(["acpi"], stderr=subprocess.STDOUT)
  acpi_unicode = acpi_raw.decode("UTF-8")

  #  Example list: ['Battery', '0:', 'Discharging', '43%', '00:59:20', 'remaining']
  acpi_list = acpi_unicode.split(' ')

  charging = acpi_list[2][:8] == "Charging"
  percent_charged = int(acpi_list[3][:-2])

  time_remaining = ' ' + acpi_list[4] if len(acpi_list) > 4 else ""

  battery_full = False

  if charging:
    full_text = str(percent_charged) + "%" + str(time_remaining)
  else:
    full_text = str(percent_charged) + "%" + str(time_remaining)

  return full_text

print(battery_text())

