#! /usr/bin/python

from __future__ import division  # python2 compatibility
from time import time

import math
import subprocess
import json

BLOCKS = ["", "", "", "", "", "", "", "", ""]
CHARGING_CHARACTER = ""
EMPTY_BLOCK_CHARGING = '|'
EMPTY_BLOCK_DISCHARGING = '⍀'
FULL_BLOCK = ''
color_good="#24708A"
color_bad="#C6572F"
color_degraded="#C6572F"
color_charging="#24708A"

def battery_text():
  response = {}
  #  Example acpi raw output:  "Battery 0: Discharging, 43%, 00:59:20 remaining"
  acpi_raw = subprocess.check_output(["acpi"], stderr=subprocess.STDOUT)
  acpi_unicode = acpi_raw.decode("UTF-8")

  #  Example list: ['Battery', '0:', 'Discharging', '43%', '00:59:20', 'remaining']
  acpi_list = acpi_unicode.split(' ')

  charging = True if acpi_list[2][:8] == "Charging" else False
  percent_charged = int(acpi_list[3][:-2])

  time_remaining = ' ' + acpi_list[4] if len(acpi_list) > 4 else ""

  battery_full = False

  if charging:
    full_text = CHARGING_CHARACTER
    #+ ' ' + str(percent_charged) + "%" + str(self.time_remaining)
  else:
    full_text = BLOCKS[int(math.ceil(percent_charged/100*(len(BLOCKS) - 1)))]
    #+ ' ' + str(percent_charged) + "%" + str(self.time_remaining)

  if percent_charged < 7 and not charging:
    subprocess.call(['twmnc',
                      '-t', 'Warning Low Battery', '-c', str(percent_charged) + '%',
                      '--bg',"#C02510",
                      '-d', '3000',
                      '-i', '~/.config/twmn/crit.png'],
                    stdout=open('/dev/null', 'w'),
                    stderr=open('/dev/null', 'w'))

  if percent_charged < 10:
    color = color_bad
  if percent_charged < 30:
    color = color_degraded
  else:
    color = color_good

  response["full_text"] = full_text
  response["color"] = color
  return json.dumps({"full_text":full_text, "color":color})

print(battery_text())
