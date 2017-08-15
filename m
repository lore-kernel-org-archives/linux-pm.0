From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v5 0/3] Introduce USB charger support in USB phy
Date: Tue, 15 Aug 2017 19:07:52 +0800
Message-ID: <cover.1502794826.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33939 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdHOLId (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2017 07:08:33 -0400
Received: by mail-pg0-f44.google.com with SMTP id u185so4046417pgb.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2017 04:08:33 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

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

Changes since v4:
 - Change the phandle name from 'usb-phy' to 'phys' for wm831x_power driver.
Changes since v3:
 - Bail out errors when failed to find usb phy for wm831x_power driver.
Changes since v2:
 - Add DT binding documentation for wm831x_power driver.
 - Change 'usb-phy' as one optional property for wm831x_power driver.
Changes since v1:
 - Fix building errors.

Baolin Wang (3):
  include: uapi: usb: Introduce USB charger type and state definition
  usb: phy: Add USB charger support
  power: wm831x_power: Support USB charger current limit management

 Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +
 drivers/power/supply/wm831x_power.c              |   72 ++++++
 drivers/usb/phy/phy.c                            |  272 ++++++++++++++++++++++
 include/linux/usb/phy.h                          |   49 ++++
 include/uapi/linux/usb/charger.h                 |   31 +++
 5 files changed, 425 insertions(+)
 create mode 100644 include/uapi/linux/usb/charger.h

-- 
1.7.9.5
