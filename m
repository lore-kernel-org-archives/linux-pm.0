From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RESEND PATCH v11 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Mon, 13 Jun 2016 16:43:12 +0800
Message-ID: <cover.1465807122.git.baolin.wang@spreadtrum.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Baolin Wang <baolin.wang@spreadtrum.com>

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should. Thus provide a standard framework for doing this in kernel.

Now introduce one user with wm831x_power to support and test the usb charger,
which is pending testing. Moreover there may be other potential users will use
it in future.

Changes since v10:
 - Introduce usb_charger_get_state() function to check charger state.
 - Remove the mutex lock in usb_charger_set_cur_limit_by_type() function
 in case will be issued in atomic context.

Baolin Wang (4):
  gadget: Introduce the usb charger framework
  gadget: Support for the usb charger framework
  gadget: Integrate with the usb gadget supporting for usb charger
  power: wm831x_power: Support USB charger current limit management

 drivers/power/wm831x_power.c      |   69 ++++
 drivers/usb/gadget/Kconfig        |    7 +
 drivers/usb/gadget/udc/Makefile   |    1 +
 drivers/usb/gadget/udc/charger.c  |  807 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/udc-core.c |   11 +
 include/linux/mfd/wm831x/pdata.h  |    3 +
 include/linux/usb/charger.h       |  191 +++++++++
 include/linux/usb/gadget.h        |   11 +
 include/uapi/linux/usb/charger.h  |   31 ++
 9 files changed, 1131 insertions(+)
 create mode 100644 drivers/usb/gadget/udc/charger.c
 create mode 100644 include/linux/usb/charger.h
 create mode 100644 include/uapi/linux/usb/charger.h

-- 
1.7.9.5
