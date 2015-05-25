From: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] Add support for Richtek RT9455 battery charger
Date: Mon, 25 May 2015 13:22:20 +0300
Message-ID: <1432549343-5756-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello,

The next 3 patches do the following:
- first patch adds Richtek Technology Corporation in the vendor-prefixes list
- second patch adds device tree binding example for Richtek RT9455 battery charger
- third patch adds the driver for Richtek RT9455 battery charger

Thanks,
Anda

Anda-Maria Nicolae (3):
  of: Add vendor prefix for Richtek Technology Corporation
  Documentation: devicetree: Add Richtek RT9455 bindings
  power_supply: Add support for Richtek RT9455 battery charger

 .../devicetree/bindings/power/rt9455_charger.txt   |   46 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/power/Kconfig                              |    7 +
 drivers/power/Makefile                             |    1 +
 drivers/power/rt9455_charger.c                     | 1821 ++++++++++++++++++++
 5 files changed, 1876 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/rt9455_charger.txt
 create mode 100644 drivers/power/rt9455_charger.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
