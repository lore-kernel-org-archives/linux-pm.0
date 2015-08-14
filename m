From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 0/3] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Fri, 14 Aug 2015 17:47:43 +0800
Message-ID: <cover.1439519412.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should.

Providing a standard framework for doing this in the kernel.

Now introduce one user with wm831x_power to support and test the usb charger,
which is pending testing. Moreover there may be other potential users will use
it in future.

Changes since v1:
 - Rebase my branch and re-create the patch series.
 - Remove the extcon wrappers and gadget wrappers for registering a notifier.
 - Remove the user count in usb charger.
 - Use idr instead of my own logic.
 - Replace the spinlock with mutex.
 - Use the list of driver core to manage the usb charger device.
 - Add the Kconfig and Makefile changes.
 - Add some attribute files to show or store the current limitation.
 - Introduce one user of usb charger by Mark Brown.
 - Other modifications.

Baolin Wang (3):
  gadget: Support for the usb charger framework
  gadget: Introduce the usb charger framework
  power: wm831x_power: Support USB charger current limit management

 drivers/power/wm831x_power.c      |   69 +++++
 drivers/usb/gadget/Kconfig        |    7 +
 drivers/usb/gadget/Makefile       |    1 +
 drivers/usb/gadget/charger.c      |  561 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/udc-core.c |   38 +++
 include/linux/mfd/wm831x/pdata.h  |    3 +
 include/linux/usb/gadget.h        |   20 ++
 include/linux/usb/usb_charger.h   |  145 ++++++++++
 8 files changed, 844 insertions(+)
 create mode 100644 drivers/usb/gadget/charger.c
 create mode 100644 include/linux/usb/usb_charger.h

-- 
1.7.9.5
