#!/usr/bin/env python

"""
Settings for fincham-dotfiles, mostly used by the templating engine (so it is expected that
this file will do some `fact discovery' about the system it is running on).

Michael Fincham <michael@hotplate.co.nz>
"""

import os
import socket

hostname = socket.gethostname()

# if the machine has a battery, it's probably at least a bit portable. this is used later for "laptop specific" stuff.
batteries = [
    entry for entry in os.listdir("/sys/class/power_supply") if entry.startswith("BAT")
]

# look for wireless interfaces to configure i3status etc
wifi_interfaces = [
    interface.split("/")[-1]
    for interface in os.listdir("/sys/class/net")
    if "phy80211" in os.listdir("/sys/class/net/%s" % interface)
]
