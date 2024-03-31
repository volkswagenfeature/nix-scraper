# Predates Huey. Depreciated?

import asyncio
import numpy
from time import sleep
import base64
import codecs

class fakewaiter:
    def __init__(self):
        self.sleeptime = numpy.random.normal(3,2)
        self.idval = codecs.decode(base64.b85encode(id(self).to_bytes(8,byteorder='big')))
    
    def info(self):
        
        return f"id ({self.idval}) will sleep {self.sleeptime:.3f} sec"
        
    def run(self):
        sleep(self.sleeptime)
        return f"id ({self.idval}) slept {self.sleeptime:.3f} sec"
    