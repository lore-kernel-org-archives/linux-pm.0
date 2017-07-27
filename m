From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 0/3] Introduce USB charger support in USB phy
Date: Thu, 27 Jul 2017 13:14:35 +0800
Message-ID: <cover.1501132171.git.baolin.wang@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: jun.li-3arQi8VN3Tc@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, neilb-IBi9RG/b67k@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
