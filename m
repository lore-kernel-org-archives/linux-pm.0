From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/9] Extend various drivers to run on bi-endian BMIPS hosts
Date: Tue, 25 Nov 2014 16:49:45 -0800
Message-ID: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch series incorporates the following changes:

 - Extend brcmstb reset driver to work on MIPS (currently ARM-only).

 - Extend brcmstb GISB bus driver to work on MIPS (currently ARM-only).

 - Extend brcmstb GISB bus driver to work on BE systems (currently LE-only).

 - Extend both drivers to support the older register layouts used on many
   of the BMIPS platforms.

 - Extend {ohci,ehci}-platform drivers to accept the new "native-endian"
   DT property, to accommodate BCM7xxx platforms that can be switched
   between LE/BE with a board jumper.


Dependencies:

power/reset: brcmstb: Register with kernel restart handler (Guenter Roeck)
of: Add helper function to check MMIO register endianness (Kevin Cernekee)

These are both tentatively accepted, but might not be present in the same
tree yet.  As such, we might want to "review now, merge later."


Kevin Cernekee (9):
  power/reset: brcmstb: Make the driver buildable on MIPS
  power/reset: brcmstb: Use the DT "compatible" string to indicate bit
    positions
  power/reset: brcmstb: Add support for old 65nm chips
  bus: brcmstb_gisb: Make the driver buildable on MIPS
  bus: brcmstb_gisb: Introduce wrapper functions for MMIO accesses
  bus: brcmstb_gisb: Look up register offsets in a table
  bus: brcmstb_gisb: Add register offset tables for older chips
  bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT
    properties
  usb: {ohci,ehci}-platform: Use new OF big-endian helper function

 .../devicetree/bindings/arm/brcm-brcmstb.txt       |   4 +-
 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |   6 +-
 Documentation/devicetree/bindings/usb/usb-ehci.txt |   2 +
 Documentation/devicetree/bindings/usb/usb-ohci.txt |   2 +
 drivers/bus/Kconfig                                |   2 +-
 drivers/bus/brcmstb_gisb.c                         | 127 ++++++++++++++++++---
 drivers/power/reset/Kconfig                        |   9 +-
 drivers/power/reset/brcmstb-reboot.c               |  41 +++++--
 drivers/usb/host/ehci-platform.c                   |   2 +-
 drivers/usb/host/ohci-platform.c                   |   2 +-
 10 files changed, 161 insertions(+), 36 deletions(-)

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
