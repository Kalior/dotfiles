#! /usr/bin/python

import random
import sys
from datetime import datetime

now = datetime.now().time()
seed = now.minute + now.hour*100
random.seed(seed)

h = random.randint(0,23)
m = random.randint(0,59)
if m < 10 and h < 10:
  print("0" + str(h) + ":0" + str(m))
elif h < 10:
  print("0" + str(h) + ":" + str(m))
elif m < 10:
  print(str(h) + ":0" + str(m))
else:
  print(str(h) + ":" + str(m))
