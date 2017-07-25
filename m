From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3 0/3] Introduce USB charger support in USB phy
Date: Tue, 25 Jul 2017 15:59:58 +0800
Message-ID: <cover.1500968744.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should. Thus provide a standard USB charger support in USB phy core
for doing this in kernel.

Now introduce one user with wm831x_power to support and test the usb charger.
In future we will also cnvert below power drivers:
drivers/power/supply/axp288_charger.c
drivers/power/supply/bq24190_charger.c
drivers/power/supply/charger-manager.c
drivers/power/supply/qcom_smbb.c

Changes since v1:
 - Fix building errors.
Changes since v2:
 - Add DT binding documentation for wm831x_power driver.
 - Change 'usb-phy' as one optional property for wm831x_power driver.

Baolin Wang (3):
  include: uapi: usb: Introduce USB charger type and state definition
  usb: phy: Add USB charger support
  power: wm831x_power: Support USB charger current limit management

 Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +
 drivers/power/supply/wm831x_power.c              |   58 +++++
 drivers/usb/phy/phy.c                            |  272 ++++++++++++++++++++++
 include/linux/usb/phy.h                          |   49 ++++
 include/uapi/linux/usb/charger.h                 |   31 +++
 5 files changed, 411 insertions(+)
 create mode 100644 include/uapi/linux/usb/charger.h

-- 
1.7.9.5
