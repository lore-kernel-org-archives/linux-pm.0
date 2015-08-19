From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 0/5] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 19 Aug 2015 17:13:43 +0800
Message-ID: <cover.1439974219.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34473 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbHSJOH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 05:14:07 -0400
Received: by pdbfa8 with SMTP id fa8so78661949pdb.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 02:14:05 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should.

Providing a standard framework for doing this in the kernel.

Now introduce one user with wm831x_power to support and test the usb charger,
which is pending testing. Moreover there may be other potential users will use
it in future.

Changes since v3:
 - Re-order the patch and split the patch to avoid breaking build.
 - Other modifications.

Baolin Wang (5):
  gadget: Introduce the notifier functions
  gadget: Introduce the usb charger framework
  gadget: Support for the usb charger framework
  gadget: Integrate with the usb gadget supporting for usb charger
  power: wm831x_power: Support USB charger current limit management

 drivers/power/wm831x_power.c      |   69 +++++
 drivers/usb/gadget/Kconfig        |    7 +
 drivers/usb/gadget/Makefile       |    1 +
 drivers/usb/gadget/charger.c      |  538 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/udc-core.c |   40 +++
 include/linux/mfd/wm831x/pdata.h  |    3 +
 include/linux/usb/gadget.h        |   20 ++
 include/linux/usb/usb_charger.h   |  138 ++++++++++
 8 files changed, 816 insertions(+)
 create mode 100644 drivers/usb/gadget/charger.c
 create mode 100644 include/linux/usb/usb_charger.h

-- 
1.7.9.5

