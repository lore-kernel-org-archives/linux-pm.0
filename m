From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 0/3] Introduce USB charger support in USB phy
Date: Mon,  3 Jul 2017 14:07:12 +0800
Message-ID: <cover.1499061617.git.baolin.wang@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: jun.li-3arQi8VN3Tc@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, neilb-IBi9RG/b67k@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should. Thus provide a standard USB charger support in USB phy core
for doing this in kernel.

Now introduce one user with wm831x_power to support and test the usb charger.

Changes since v1:
 - Fix building errors.

Baolin Wang (3):
  include: uapi: usb: Introduce USB charger type and state definition
  usb: phy: Add USB charger support
  power: wm831x_power: Support USB charger current limit management

 drivers/power/supply/wm831x_power.c |   61 ++++++++
 drivers/usb/phy/phy.c               |  265 +++++++++++++++++++++++++++++++++++
 include/linux/usb/phy.h             |   49 +++++++
 include/uapi/linux/usb/charger.h    |   31 ++++
 4 files changed, 406 insertions(+)
 create mode 100644 include/uapi/linux/usb/charger.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
