import numpy
from time import sleep
import base64
import codecs

import huey

hue = huey.SqliteHuey()

@hue.task()
def returnval(a,b):
    return a+b

