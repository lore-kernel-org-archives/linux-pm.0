From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v7 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Mon,  4 Jan 2016 11:04:26 +0800
Message-ID: <cover.1451876014.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34027 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbcADDFg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jan 2016 22:05:36 -0500
Received: by mail-pf0-f172.google.com with SMTP id e65so141743349pfe.1
        for <linux-pm@vger.kernel.org>; Sun, 03 Jan 2016 19:05:36 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should. Thus provide a standard framework for doing this in kernel.

Now introduce one user with wm831x_power to support and test the usb charger,
which is pending testing. Moreover there may be other potential users will use
it in future.

Changes since v5:
 - Remove the notifier chain things from the gadget and introduce one callback
 function to report to the usb charger when the gadget state is changed.
 - Flesh out the port type detection which combines the USB negotiation and
 PMICs detection.
 - Supply the notification mechanism to userspace when charger state is changed.
 - Integrate with the vbus staff in the gadget API.
 - Spilt up the functionality for userspace with one file per USB charger type.
 - Rebase on "4.4-rc7". 

Baolin Wang (4):
  gadget: Introduce the usb charger framework
  gadget: Support for the usb charger framework
  gadget: Integrate with the usb gadget supporting for usb charger
  power: wm831x_power: Support USB charger current limit management

 drivers/power/wm831x_power.c      |   69 ++++
 drivers/usb/gadget/Kconfig        |    7 +
 drivers/usb/gadget/Makefile       |    1 +
 drivers/usb/gadget/charger.c      |  708 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/udc-core.c |   11 +
 include/linux/mfd/wm831x/pdata.h  |    3 +
 include/linux/usb/gadget.h        |   11 +
 include/linux/usb/usb_charger.h   |  164 +++++++++
 8 files changed, 974 insertions(+)
 create mode 100644 drivers/usb/gadget/charger.c
 create mode 100644 include/linux/usb/usb_charger.h

-- 
1.7.9.5

