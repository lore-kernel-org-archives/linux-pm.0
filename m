From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v8 0/4] mfd: rt5033: Add Richtek RT5033 drivers
Date: Tue, 09 Dec 2014 21:03:50 +0900
Message-ID: <1418126634-4781-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sameo@linux.intel.com, lee.jone@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, cw00.choi@samsung.com, geunsik.lim@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-pm@vger.kernel.org

 This patchset adds driver for Richtek rt5033 chip The chip contains
switching charge mode Li-Ion/Li-Polymer battery charger, fuelgauge, regulators.
This patchset provides common support for accessing the device.
This patchset have been tested base on exynos board.

Changes in v8
- Add description of hardware.
- Move structure.

Changes in v7
- Use small description.
- Change some names for a variable.
- Revise of_device_id struct style.

Changes in v6
- Fix white space issue in mfd cell struct.

Changes in v5
- Change possible built as a module.
- Revise rt5033_dev mfd cell entry.
- Fix incorrect typo.
- Add module alias.

Changes in v4
- rt5033 regulator patch is applied by Mark Brown.

Changes in v3
- Correct sentence errors.
- Add author information the top of each drivers.
- Remove unnecessary pre-initialise, struct member(rt5033->i2c) and blink.
- Change some return check.
- Use bool and of_match_ptr().

Changes in v2:
- Remove volatile_reg callback. Because this driver not in use regmap cache.
- Remove unnecessary subnode of_compatible.
- Add definde for set high impedance mode of charger.
- Remove unnecessary device specific code.
- Fix wrong register name.
- Fix wrong error message.
- Fix return vallue at error case.
- Revise binding documentation.

Beomho Seo (4):
  mfd: rt5033: Add Richtek RT5033 driver core.
  power: rt5033_battery: Add RT5033 Fuel gauge device driver
  power: rt5033_charger: Add RT5033 charger device driver
  Documentation: Add documentation for rt5033 multifunction device

 Documentation/devicetree/bindings/mfd/rt5033.txt   |  108 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/mfd/Kconfig                                |   12 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/rt5033.c                               |  142 ++++++
 drivers/power/Kconfig                              |   16 +
 drivers/power/Makefile                             |    2 +
 drivers/power/rt5033_battery.c                     |  177 +++++++
 drivers/power/rt5033_charger.c                     |  485 ++++++++++++++++++++
 include/linux/mfd/rt5033-private.h                 |  260 +++++++++++
 include/linux/mfd/rt5033.h                         |   62 +++
 11 files changed, 1266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rt5033.txt
 create mode 100644 drivers/mfd/rt5033.c
 create mode 100644 drivers/power/rt5033_battery.c
 create mode 100644 drivers/power/rt5033_charger.c
 create mode 100644 include/linux/mfd/rt5033-private.h
 create mode 100644 include/linux/mfd/rt5033.h

-- 
1.7.9.5
