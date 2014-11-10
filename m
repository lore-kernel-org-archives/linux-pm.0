From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 0/5] mfd: rt5033: Add Richtek RT5033 drivers
Date: Mon, 10 Nov 2014 16:19:42 +0900
Message-ID: <1415603987-32475-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: cw00.choi@samsung.com, geunsik.lim@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-pm@vger.kernel.org

 This patchset adds driver for Richtek rt5033 chip The chip contains
switching charge mode Li-Ion/Li-Polymer battery charger, fuelgauge, regulators.
This patchset provides common support for accessing the device.
This patchset have been tested base on exynos board.

Changes in v2:
- Remove volatile_reg callback. Because this driver not in use regmap cache.
- Remove unnecessary subnode of_compatible.
- Add definde for set high impedance mode of charger.
- Remove unnecessary device specific code.
- Fix wrong register name.
- Fix wrong error message.
- Fix return vallue at error case.
- Revise binding documentation.

Beomho Seo (5):
  mfd: rt5033: Add Richtek RT5033 driver core.
  regulator: rt5033: Add RT5033 Regulator device driver
  power: rt5033_battery: Add RT5033 Fuel gauge device driver
  power: rt5033_charger: Add RT5033 charger device driver
  Documentation: Add documentation for rt5033 multifunction device

 Documentation/devicetree/bindings/mfd/rt5033.txt   |  108 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/mfd/Kconfig                                |   11 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/rt5033.c                               |  156 +++++++
 drivers/power/Kconfig                              |   16 +
 drivers/power/Makefile                             |    2 +
 drivers/power/rt5033_battery.c                     |  177 +++++++
 drivers/power/rt5033_charger.c                     |  485 ++++++++++++++++++++
 drivers/regulator/Kconfig                          |    8 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/rt5033-regulator.c               |  123 +++++
 include/linux/mfd/rt5033-private.h                 |  260 +++++++++++
 include/linux/mfd/rt5033.h                         |   64 +++
 14 files changed, 1413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rt5033.txt
 create mode 100644 drivers/mfd/rt5033.c
 create mode 100644 drivers/power/rt5033_battery.c
 create mode 100644 drivers/power/rt5033_charger.c
 create mode 100644 drivers/regulator/rt5033-regulator.c
 create mode 100644 include/linux/mfd/rt5033-private.h
 create mode 100644 include/linux/mfd/rt5033.h

-- 
1.7.9.5
