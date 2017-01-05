From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH v2 0/3] power: bq27xxx: add support for NVRAM R/W access
Date: Wed,  4 Jan 2017 18:10:04 -0800
Message-ID: <20170105021007.22088-1-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Enable access to the NVRAM for the bq27425 chipset which allows to
update the battery metrics that are used in the state machine.

This allows adjustments of a termination voltage, design energy, and
design voltage.

Changes from v1:
* add documentation for mWh and mAh property units
* change devicetree entries to match new property units

Matt Ranostay (3):
  devicetree: property-units: add mWh and mAh units
  devicetree: bq27425: add documentation for bq27425 fuel gauge
  power: bq27xxx: add support for NVRAM R/W access

 .../devicetree/bindings/power/bq27425.txt          |  25 ++
 .../devicetree/bindings/property-units.txt         |   2 +
 drivers/power/supply/bq27xxx_battery_i2c.c         | 335 +++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h              |   4 +
 4 files changed, 366 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/bq27425.txt

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
