From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3 0/3] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Tue, 18 Aug 2015 19:14:18 +0800
Message-ID: <cover.1439866451.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33154 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbbHRLOv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 07:14:51 -0400
Received: by pdrh1 with SMTP id h1so67842823pdr.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2015 04:14:51 -0700 (PDT)
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

Changes since v2:
 - Use macro DEVICE_ATTR_RW()/ATTRIBUTE_GROUPS() and change the method to
   register the attruibutes.
 - Remove the 'name' and 'entry' member of struct 'usb_charger'.
 - Replace devm_kzalloc() with kzalloc() to follow the the lifetime rules.
 - Other modifications.

Baolin Wang (3):
  gadget: Support for the usb charger framework
  gadget: Introduce the usb charger framework
  power: wm831x_power: Support USB charger current limit management

 drivers/power/wm831x_power.c      |   69 +++++
 drivers/usb/gadget/Kconfig        |    7 +
 drivers/usb/gadget/Makefile       |    1 +
 drivers/usb/gadget/charger.c      |  538 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/udc-core.c |   41 ++-
 include/linux/mfd/wm831x/pdata.h  |    3 +
 include/linux/usb/gadget.h        |   20 ++
 include/linux/usb/usb_charger.h   |  138 ++++++++++
 8 files changed, 816 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/gadget/charger.c
 create mode 100644 include/linux/usb/usb_charger.h

-- 
1.7.9.5

