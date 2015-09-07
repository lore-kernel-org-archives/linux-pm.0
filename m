From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [Resend PATCH v3] modify pl011 driver to work as wakeup source
Date: Mon,  7 Sep 2015 14:52:03 +0800
Message-ID: <1441608723-2234-1-git-send-email-zhaoyang.huang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35819 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbbIGGw0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 02:52:26 -0400
Received: by pacfv12 with SMTP id fv12so89961625pac.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2015 23:52:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.kucheria@linaro.org

the commit use the latest dev_pm_set_wake_irq API instead
of the enable_irq_wake and IRQF_NO_SUSPEND to configure the
ttyAMA device to work as the wakeup source

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fd27e98..26d2902 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -59,6 +59,11 @@
 #include <linux/sizes.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/irq.h>
+
+static struct device *uart_dev;
 
 #define UART_NR			14
 
@@ -2353,11 +2358,29 @@ static int pl011_register_port(struct uart_amba_port *uap)
 	return ret;
 }
 
+struct uart_match {
+	struct uart_port *port;
+	struct uart_driver *driver;
+};
+
+static int match_uart_port(struct device *dev, void *data)
+{
+	struct uart_match *match = data;
+
+	dev_t devt = MKDEV(match->driver->major, match->driver->minor) +
+		match->port->line;
+
+	pr_info("the match data of ttyAMA0 is %d %d\n",
+			(int)devt, (int)dev->devt);
+
+	return dev->devt == devt; /* Actually, only one tty per port */
+}
 static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
 	int portnr, ret;
+	struct uart_match match;
 
 	portnr = pl011_find_free_port();
 	if (portnr < 0)
@@ -2387,13 +2410,30 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 
 	amba_set_drvdata(dev, uap);
 
-	return pl011_register_port(uap);
+	ret = pl011_register_port(uap);
+
+	match.port = &uap->port;
+	match.driver = &amba_reg;
+
+	uart_dev = device_find_child(&dev->dev, &match, match_uart_port);
+
+	if (uart_dev) {
+		device_init_wakeup(uart_dev, true);
+		dev_pm_set_wake_irq(uart_dev, uap->port.irq);
+	}
+
+	return ret;
 }
 
 static int pl011_remove(struct amba_device *dev)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
 
+	if (uart_dev) {
+		dev_pm_clear_wake_irq(uart_dev);
+		device_init_wakeup(uart_dev, false);
+	}
+
 	uart_remove_one_port(&amba_reg, &uap->port);
 	pl011_unregister_port(uap);
 	return 0;
-- 
1.7.9.5

