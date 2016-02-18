# -*- coding: utf-8 -*-
from __future__ import division  # python2 compatibility
from time import time

import math
import subprocess

BLOCKS = ["", "", "", "", ""]


class Py3status:
    """
    """
    # available configuration parameters
    cache_timeout = 30
    interface = "wlp58s0"
    color_bad = "#C6572F"
    color_good = "#24708A"
    color_degraded = "#C6572F"
    format = "{}"

    def wifi_status(self, i3s_output_list, i3s_config):
        response = {}

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

        ip_raw = subprocess.check_output(["iw", "dev", self.interface, "link"], stderr=subprocess.STDOUT)
        ip_unicode = ip_raw.decode("UTF-8")

        if ip_unicode == "Not connected.\n":
            response['full_text'] = self.format.format(BLOCKS[0])
                #"No connection " + 
        else:
            #  Example list: [\tConnected to d0:c7:89:25:81:21 (on wlo1), \tSSID: eduroam, \tfreq: 2412, \tRX: 8833778 bytes (41357 packets) etc.]
            ip_list = ip_unicode.split('\n')

            ssid = ip_list[1].split(' ')[1] 

            signal_strength = int(ip_list[5].split(' ')[1])
            
            
            signal_block = ""
            if signal_strength > -50:
                signal_block = BLOCKS[4]
                response['color'] = (
                    self.color_good
                    if self.color_good
                    else i3s_config['color_good']
                    )
            elif signal_strength > -55:
                signal_block = BLOCKS[3]
                response['color'] = (
                    self.color_good
                    if self.color_good
                    else i3s_config['color_good']
                    )
            elif signal_strength > -60:
                signal_block = BLOCKS[2]
                response['color'] = (
                    self.color_degraded
                    if self.color_degraded
                    else i3s_config['color_degraded']
                    )
            elif signal_strength > -70:
                signal_block = BLOCKS[1]
                response['color'] = (
                    self.color_bad
                    if self.color_bad
                    else i3s_config['color_bad']
                    )
            else: 
                signal_block = BLOCKS[0]
                response['color'] = (
                        self.color_bad
                        if self.color_bad
                        else i3s_config['color_bad']
                        )
                

            response['full_text'] = self.format.format(signal_block)
            response['cached_until'] = time() + self.cache_timeout

        return response



if __name__ == "__main__":
    from time import sleep
    x = Py3status()
    config = {
        'color_good': '#00FF00',
        'color_bad': '#FF0000',
        'interface': 'wlo1'
    }
    while True:
        print(x.wifi_status([], config))
        sleep(1)