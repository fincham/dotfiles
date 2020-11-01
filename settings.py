#!/usr/bin/python3

"""
Settings for fincham-dotfiles, mostly used by the templating engine (so it is expected that
this file will do some `fact discovery' about the system it is running on).

Michael Fincham <michael@hotplate.co.nz>
"""

import os
import platform
import socket

hostname = socket.gethostname()
run_dir = os.environ.get('XDG_RUNTIME_DIR', '/run/user/%i' % os.getuid())

# if the machine has a battery, it's probably at least a bit portable. this is used later for "laptop specific" stuff.
if platform.system() == "Linux":
    batteries = [
        entry for entry in os.listdir("/sys/class/power_supply") if entry.startswith("BAT")
    ]
    # look for wireless interfaces to configure i3status etc
    wifi_interfaces = [
        interface.split("/")[-1]
        for interface in os.listdir("/sys/class/net")
        if "phy80211" in os.listdir("/sys/class/net/%s" % interface)
    ]
else:
    batteries = []
    wifi_interfaces = []

