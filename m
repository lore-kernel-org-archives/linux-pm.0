From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v8 0/2] Add new MFD driver for MAX77843
Date: Tue, 31 Mar 2015 22:23:33 +0900
Message-ID: <1427808215-19178-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, sre@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, cw00.choi@samsung.com, sangbae90.lee@samsung.com, inki.dae@samsung.com, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch series adds MAX77843(Multi Function Device) driver.
The MAX77843 includes MUIC(Micro USB Interface Controller), Li+ Charger
with Fuel Gauge, 2 safeout LDOs for USB device and haptic controller using PWM.
It is interfaced to host controller using I2C.

Changes in v8:
Charger:
 - Add "Reviewed-by: Sebastian Reichel" He reviewed this patch on Sun 8 Mar 2015.

Fuelgauge:
 - Remove patch.

Doc:
 - Remove about fuelgague.

Changes in v7:
MFD Core
 - Fix indentation
 - Remove file name, MODULE information
POWER
 - Fix typos

Changes in v6:
HAPTIC
 - fixed a situation where holding a Mutex return.
 
Changes in v5: 
MFD Core
 - Use bracket in complex define.
 - Delete unnecessary letter '++'     
Charger
 - fix Kconfig merge conflict with Kernel version4.0
     
Changes in v4:
MFD Core
 - Fix indentation
 - Add haptic register define in header
HAPTIC
 - Add haptic driver

Changes in v3:
MFD Core
 - Fix wrong description and indentation in header.
 - Remove unnecessary variable.
Regulator
 - Use ARRAY_SIZE() instead of define.
   
Changes in v2:
MFD Core
 - Fix charger regmap handle and typo.
MUIC
 - Cleanup enum list.
 - Set path before send excon event.
 - Fix variable names and typos for readability.
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

Beomho Seo (1):
  power: max77843_charger: Add Max77843 charger device driver

Jaewon Kim (1):
  Documentation: Add device tree bindings document for max77843

 Documentation/devicetree/bindings/mfd/max77843.txt |  100 ++++
 drivers/power/Kconfig                              |    7 +
 drivers/power/Makefile                             |    1 +
 drivers/power/max77843_charger.c                   |  508 ++++++++++++++++++++
 4 files changed, 616 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77843.txt
 create mode 100644 drivers/power/max77843_charger.c

-- 
1.7.9.5
