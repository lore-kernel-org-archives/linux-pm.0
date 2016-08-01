From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Mon,  1 Aug 2016 15:09:29 +0800
Message-ID: <cover.1470034830.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should. Thus provide a standard framework for doing this in kernel.

Now introduce one user with wm831x_power to support and test the usb charger,
which is pending testing. Moreover there may be other potential users will use
it in future.

CHanges since v15:
 - Add charger state checking to avoid sending out duplicate notifies to users.
 - Add one work to notify power users the current has been changed.

Changes since v14:
 - Add kernel documentation for struct usb_cahrger.
 - Remove some redundant WARN() functions.

Changes since v13:
 - Remove the charger checking in usb_gadget_vbus_draw() function.
 - Rename some functions in charger.c file.
 - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tags/usb-for-v4.8

Changes since v12:
 - Remove the class and device things.
 - Link usb charger to udc-core.ko.
 - Create one "charger" subdirectory which holds all charger-related attributes.

Changes since v11:
 - Reviewed and tested by Li Jun.

Changes since v10:
 - Introduce usb_charger_get_state() function to check charger state.
 - Remove the mutex lock in usb_charger_set_cur_limit_by_type() function
 in case will be issued in atomic context.

Baolin Wang (4):
  usb: gadget: Introduce the usb charger framework
  usb: gadget: Support for the usb charger framework
  usb: gadget: Integrate with the usb gadget supporting for usb charger
  power: wm831x_power: Support USB charger current limit management

 drivers/power/wm831x_power.c     |   69 ++++
 drivers/usb/gadget/Kconfig       |    8 +
 drivers/usb/gadget/udc/Makefile  |    1 +
 drivers/usb/gadget/udc/charger.c |  780 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/core.c    |   17 +
 include/linux/mfd/wm831x/pdata.h |    3 +
 include/linux/usb/charger.h      |  186 +++++++++
 include/linux/usb/gadget.h       |    3 +
 include/uapi/linux/usb/charger.h |   31 ++
 9 files changed, 1098 insertions(+)
 create mode 100644 drivers/usb/gadget/udc/charger.c
 create mode 100644 include/linux/usb/charger.h
 create mode 100644 include/uapi/linux/usb/charger.h

-- 
1.7.9.5
