From: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/6] Add new MFD driver for MAX77843
Date: Tue, 03 Feb 2015 14:04:00 +0900
Message-ID: <1422939846-29955-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, SangBae Lee <sangbae90.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch series adds MAX77843(Multi Function Device) driver.
The MAX77843 includes MUIC(Micro USB Interface Circuit), Li+ Charger
with Fuel Gauge and 2 safeout LDOs for USB device.
It is interfaced to host controller using I2C.

Changes in V2:
MFD Core
 - Fix charger regmap handle and typo.
MUIC
 - cleanup enum list.
 - set path before send excon event.
 - fix variable names and typos for readability.
Charger
 - Remove unnecessary header.
 - Chnage error message more readable.
 - Remove unnecessary lines.
Fuelgauge
 - Fix regmap_config and use regmap_read.
 - Add i2c_unregister_device function on *_remove function.
 - Fix typo in Kconfig.
Doc
 - Remove unnecessary lines.
 - Add example of charger regulator.

Beomho Seo (2):
  power: max77843_charger: Add Max77843 charger device driver
  power: max77843_battery: Add Max77843 fuel gauge device driver

Jaewon Kim (4):
  mfd: max77843: Add max77843 MFD driver core driver
  extcon: max77843: Add max77843 MUIC driver
  regulator: max77843: Add max77843 regulator driver
  Documentation: Add device tree bindings document for max77843

 Documentation/devicetree/bindings/mfd/max77843.txt |   90 ++
 drivers/extcon/Kconfig                             |   10 +
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/extcon-max77843.c                   |  881 ++++++++++++++++++++
 drivers/mfd/Kconfig                                |   14 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/max77843.c                             |  247 ++++++
 drivers/power/Kconfig                              |   16 +
 drivers/power/Makefile                             |    2 +
 drivers/power/max77843_battery.c                   |  286 +++++++
 drivers/power/max77843_charger.c                   |  508 +++++++++++
 drivers/regulator/Kconfig                          |    8 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/max77843.c                       |  229 +++++
 include/linux/mfd/max77843-private.h               |  422 ++++++++++
 15 files changed, 2716 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77843.txt
 create mode 100644 drivers/extcon/extcon-max77843.c
 create mode 100644 drivers/mfd/max77843.c
 create mode 100644 drivers/power/max77843_battery.c
 create mode 100644 drivers/power/max77843_charger.c
 create mode 100644 drivers/regulator/max77843.c
 create mode 100644 include/linux/mfd/max77843-private.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
