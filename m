From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [PATCH] modify pl011 driver to work as wakeup source
Date: Fri, 14 Aug 2015 18:24:46 +0800
Message-ID: <1439547886-5093-1-git-send-email-zhaoyang.huang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35455 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbHNKYz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 06:24:55 -0400
Received: by pdrg1 with SMTP id g1so29998837pdr.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2015 03:24:54 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.kucheria@linaro.org

add IRQF_NO_SUSPEND flag when requiring irq line and call
the pm_system_wakeup when RX interrupt happens

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 50cf5b1..6285819 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -59,6 +59,7 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
 
 #define UART_NR			14
 
@@ -127,6 +128,7 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
+static int is_suspended = 0;
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
@@ -1376,6 +1378,10 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
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
@@ -1585,7 +1591,7 @@ static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
 	writew(uap->im, uap->port.membase + UART011_IMSC);
 
-	return request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
+	return request_irq(uap->port.irq, pl011_int, IRQF_NO_SUSPEND, "uart-pl011", uap);
 }
 
 /*
@@ -2403,21 +2409,33 @@ static int pl011_remove(struct amba_device *dev)
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

