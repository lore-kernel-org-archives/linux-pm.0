From: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Subject: [PATCH v3 0/2] power: supply: add sbs-charger driver
Date: Thu, 24 Nov 2016 13:33:41 +0100
Message-ID: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

This series adds support for all SBS compatible battery chargers, as defined
here: http://sbs-forum.org/specs/sbc110.pdf.

The first patch changes the sbs-battery device name in order to be able to
create a proper supplier/supplied relation between the two of them.

The second introduces the driver.

Regards,
Nicolas

changes since v2:
- updated driver and dt-binding with Sebatian's comments

changes since v1:
- added dt bindings
- updated driver with Sebastian's comments
- s/Nicola/Nicolas/ in commits

Nicolas Saenz Julienne (2):
  power: supply: add sbs-charger driver
  dt-bindings: power: add bindings for sbs-charger

 .../bindings/power/supply/sbs_sbs-charger.txt      |  24 ++
 drivers/power/supply/Kconfig                       |   6 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sbs-charger.c                 | 275 +++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
 create mode 100644 drivers/power/supply/sbs-charger.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
