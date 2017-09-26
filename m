From: Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>
Subject: [PATCH v5 0/2] thermal: add brcmstb AVS TMON driver
Date: Tue, 26 Sep 2017 14:27:57 -0700
Message-ID: <20170926212800.4879-1-code@mmayer.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
Cc: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

This series adds the brcmstb AVS TMON driver.

The driver was originally written by Brian Norris.

Changes since v4:
- disable trip points properly when needed; there was code left-over
  from an older iteration of this driver that used long ints, which
  resulted in code that was incorrect now that we are using ints
- rebased on v4.14-rc1
- patches 3 & 4 (turning on CONFIG_BRCMSTB_THERMAL for arm/arm64) are no
  longer part of the series, because they were already picked up for 4.14

Changes since v3:
- Rebased on v4.13-rc3 to resolve conflicts in the MAINTAINERS file

Changes since v2:
- replaced calls to pr_debug() with calls to dev_dbg() [PATCH 2/4 only]
- all other patches are unchanged from v2

Changes since v1:
- Fixed wording in binding document
- Fixed lincensing to consistently mention GPL v2
- Use thermal_zone_get_slope() and thermal_zone_get_offset()
- Some minor clean-ups

Brian Norris (2):
  Documentation: devicetree: add binding for Broadcom STB AVS TMON
  thermal: add brcmstb AVS TMON driver

 .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  20 ++
 MAINTAINERS                                        |   8 +
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/broadcom/Kconfig                   |   7 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/brcmstb_thermal.c         | 387 +++++++++++++++++++++
 6 files changed, 424 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
