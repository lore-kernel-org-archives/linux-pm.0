From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v10 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Thu,  7 Apr 2016 19:48:42 +0800
Message-ID: <cover.1460029375.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34747 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbcDGLtv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 07:49:51 -0400
Received: by mail-pf0-f169.google.com with SMTP id c20so54617561pfc.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 04:49:51 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should. Thus provide a standard framework for doing this in kernel.

Now introduce one user with wm831x_power to support and test the usb charger,
which is pending testing. Moreover there may be other potential users will use
it in future.

Changes since v9:
 - Remove some redundant sysfs attributes.
 - Change the SDP charger default current if gadget is SS.
 - Remove the 'get_charger_type' callback in gadget->ops.

Baolin Wang (4):
  gadget: Introduce the usb charger framework
  gadget: Support for the usb charger framework
  gadget: Integrate with the usb gadget supporting for usb charger
  power: wm831x_power: Support USB charger current limit management

 drivers/power/wm831x_power.c      |   69 ++++
 drivers/usb/gadget/Kconfig        |    7 +
 drivers/usb/gadget/udc/Makefile   |    1 +
 drivers/usb/gadget/udc/charger.c  |  766 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/udc-core.c |   11 +
 include/linux/mfd/wm831x/pdata.h  |    3 +
 include/linux/usb/charger.h       |  173 +++++++++
 include/linux/usb/gadget.h        |   13 +
 include/uapi/linux/usb/charger.h  |   31 ++
 9 files changed, 1074 insertions(+)
 create mode 100644 drivers/usb/gadget/udc/charger.c
 create mode 100644 include/linux/usb/charger.h
 create mode 100644 include/uapi/linux/usb/charger.h

-- 
1.7.9.5

