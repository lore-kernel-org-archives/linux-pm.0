From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH 0/3] power: bq27xxx: add support for NVRAM R/W access
Date: Sun, 25 Dec 2016 21:44:39 -0800
Message-ID: <20161226054442.23599-1-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Enable access to the NVRAM for the bq27425 chipset which allows to
update the battery metrics that are used in the state machine.

This allows adjustments of a termination voltage, design energy, and
design voltage.

Matt Ranostay (3):
  bq27xxx_battery: add BQ27425 chip id
  devicetree: bq27425: add documentation for bq27425 fuel gauge
  power: bq27xxx: add support for NVRAM R/W access

 .../devicetree/bindings/power/bq27425.txt          |  25 ++
 drivers/power/supply/bq27xxx_battery.c             |  24 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         | 336 ++++++++++++++++++++-
 include/linux/power/bq27xxx_battery.h              |   7 +-
 4 files changed, 388 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/bq27425.txt

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
