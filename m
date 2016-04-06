From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] extcon: usb-gpio: switch to use pm wakeirq apis
Date: Wed, 6 Apr 2016 20:32:37 +0300
Message-ID: <1459963957-21883-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57060 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbcDFRdX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Apr 2016 13:33:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: nsekhar@ti.com, nm@ti.com, rogerq@ti.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, Grygorii Strashko <grygorii.strashko@ti.com>

Switch to use PM wakeirq APIs which automates wakeup IRQs
enabling/disabling and so allows to make code simpler.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Unfortunately this simple patch depends on:
"[RFC PATCH] PM / wakeirq: fix wakeirq setting after wakup re-configuration from sysfs"
https://lkml.org/lkml/2016/4/6/296

 drivers/extcon/extcon-usb-gpio.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index 2b2fecf..bc61d11 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -141,7 +142,8 @@ static int usb_extcon_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, info);
-	device_init_wakeup(dev, 1);
+	device_init_wakeup(dev, true);
+	dev_pm_set_wake_irq(dev, info->id_irq);
 
 	/* Perform initial detection */
 	usb_extcon_detect_cable(&info->wq_detcable.work);
@@ -155,6 +157,9 @@ static int usb_extcon_remove(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&info->wq_detcable);
 
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+
 	return 0;
 }
 
@@ -164,12 +169,6 @@ static int usb_extcon_suspend(struct device *dev)
 	struct usb_extcon_info *info = dev_get_drvdata(dev);
 	int ret = 0;
 
-	if (device_may_wakeup(dev)) {
-		ret = enable_irq_wake(info->id_irq);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * We don't want to process any IRQs after this point
 	 * as GPIOs used behind I2C subsystem might not be
@@ -185,12 +184,6 @@ static int usb_extcon_resume(struct device *dev)
 	struct usb_extcon_info *info = dev_get_drvdata(dev);
 	int ret = 0;
 
-	if (device_may_wakeup(dev)) {
-		ret = disable_irq_wake(info->id_irq);
-		if (ret)
-			return ret;
-	}
-
 	enable_irq(info->id_irq);
 
 	return ret;
-- 
2.8.0

