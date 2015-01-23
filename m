From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 0/6] Add new MFD driver for MAX77843
Date: Fri, 23 Jan 2015 14:02:41 +0900
Message-ID: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch series adds MAX77843(Multi Function Device) driver.
The MAX77843 includes MUIC(Micro USB Interface Circuit), Li+ Charger
with Fuel Gauge and 2 safeout LDOs for USB device.
It is interfaced to host controller using I2C.

Beomho Seo (2):
  power: max77843_charger: Add Max77843 charger device driver
  power: max77843_battery: Add Max77843 fuel gauge device driver

Jaewon Kim (4):
  mfd: max77843: Add max77843 MFD driver core driver
  extcon: max77843: Add max77843 MUIC driver
  regulator: max77843: Add max77843 regulator driver
  Documentation: Add device tree bindings document for max77843

 Documentation/devicetree/bindings/mfd/max77843.txt |   87 ++
 drivers/extcon/Kconfig                             |   10 +
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/extcon-max77843.c                   |  871 ++++++++++++++++++++
 drivers/mfd/Kconfig                                |   14 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/max77843.c                             |  241 ++++++
 drivers/power/Kconfig                              |   16 +
 drivers/power/Makefile                             |    2 +
 drivers/power/max77843_battery.c                   |  283 +++++++
 drivers/power/max77843_charger.c                   |  506 ++++++++++++
 drivers/regulator/Kconfig                          |    8 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/max77843.c                       |  259 ++++++
 include/linux/mfd/max77843-private.h               |  410 +++++++++
 15 files changed, 2710 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77843.txt
 create mode 100644 drivers/extcon/extcon-max77843.c
 create mode 100644 drivers/mfd/max77843.c
 create mode 100644 drivers/power/max77843_battery.c
 create mode 100644 drivers/power/max77843_charger.c
 create mode 100644 drivers/regulator/max77843.c
 create mode 100644 include/linux/mfd/max77843-private.h

-- 
1.7.9.5
