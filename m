From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [PATCH v2] modify the pl011 driver to let it work as wakeup source
Date: Tue,  1 Sep 2015 17:35:49 +0800
Message-ID: <1441100149-28071-1-git-send-email-zhaoyang.huang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35415 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbbIAJgB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 05:36:01 -0400
Received: by pacdd16 with SMTP id dd16so171099645pac.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2015 02:36:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.kucheria@linaro.org

the commit use the latest dev_pm_set_wake_irq API instead
of the enable_irq_wake and IRQF_NO_SUSPEND to configure the
ttyAMA device to work as the wakeup source

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   55 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 50cf5b1..33a479a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -59,6 +59,10 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
+#include <linux/pm_wakeirq.h>
+#include "../../base/power/power.h"
+#include <linux/irq.h>
 
 #define UART_NR			14
 
@@ -127,6 +131,7 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
+static int is_suspended = 0;
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
@@ -1376,6 +1381,10 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 					pl011_dma_rx_irq(uap);
 				else
 					pl011_rx_chars(uap);
+
+				if(is_suspended)
+					pm_system_wakeup();
+
 			}
 			if (status & (UART011_DSRMIS|UART011_DCDMIS|
 				      UART011_CTSMIS|UART011_RIMIS))
@@ -2353,11 +2362,29 @@ static int pl011_register_port(struct uart_amba_port *uap)
 	return ret;
 }
 
+struct uart_match {
+	struct uart_port *port;
+	struct uart_driver *driver;
+};
+
+static int match_uart_port(struct device * dev, void * data)
+{
+	struct uart_match *match = data;
+
+	dev_t devt = MKDEV(match->driver->major, match->driver->minor) +
+		match->port->line;
+
+	pr_info("the match data of ttyAMA0 is %d %d\n",(int)devt,(int)dev->devt);
+
+	return dev->devt == devt; /* Actually, only one tty per port */
+}
 static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
 	int portnr, ret;
+	struct device * uart_dev;
+	struct uart_match match;
 
 	portnr = pl011_find_free_port();
 	if (portnr < 0)
@@ -2387,7 +2414,17 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 
 	amba_set_drvdata(dev, uap);
 
-	return pl011_register_port(uap);
+	ret = pl011_register_port(uap);
+
+	match.port = &uap->port;
+	match.driver = &amba_reg;
+
+	uart_dev = device_find_child(&dev->dev, &match,match_uart_port);
+
+       device_init_wakeup(uart_dev, true);
+       dev_pm_set_wake_irq(uart_dev, uap->port.irq);
+
+	return ret;
 }
 
 static int pl011_remove(struct amba_device *dev)
@@ -2403,21 +2440,33 @@ static int pl011_remove(struct amba_device *dev)
 static int pl011_suspend(struct device *dev)
 {
 	struct uart_amba_port *uap = dev_get_drvdata(dev);
+	int ret = 0;
 
 	if (!uap)
 		return -EINVAL;
 
-	return uart_suspend_port(&amba_reg, &uap->port);
+	ret =uart_suspend_port(&amba_reg, &uap->port);
+
+	if(!ret)
+		is_suspended = 1;
+
+	return ret;
 }
 
 static int pl011_resume(struct device *dev)
 {
 	struct uart_amba_port *uap = dev_get_drvdata(dev);
+	int ret = 0;
 
 	if (!uap)
 		return -EINVAL;
 
-	return uart_resume_port(&amba_reg, &uap->port);
+	ret = uart_resume_port(&amba_reg, &uap->port);
+
+	if(!ret)
+		is_suspended = 0;
+
+	return ret;
 }
 #endif
 
-- 
1.7.9.5

