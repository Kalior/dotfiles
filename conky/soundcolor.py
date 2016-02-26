#! /usr/bin/python
import subprocess
def soundicon():
  sound_raw = subprocess.check_output(["amixer", "-c", "0", "get", "Master"], stderr=subprocess.STDOUT)
  sound_unicode = sound_raw.decode("UTF-8")
  sound_list = sound_unicode.split(' ')

  sound_on = sound_list[26][:-1]

  if sound_on == "[on]":
    full_text = "#24708A"
  else:
    full_text = "#C6572F"

  return full_text

print(soundicon())
