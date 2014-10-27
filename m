From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 25/47] power/reset: qnap-poweroff: Register with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:32 -0700
Message-ID: <1414425354-10359-26-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50143 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbaJ0P5C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 11:57:02 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XimfG-000cWH-1M
	for linux-pm@vger.kernel.org; Mon, 27 Oct 2014 15:57:02 +0000
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with default priority to reflect that the original
code generates an error if another power-off handler has already been
registered when the driver is loaded.

Drop remove function since it is no longer needed.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use devm_register_power_off_handler
- Drop remove function since it is no longer needed

 drivers/power/reset/qnap-poweroff.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index a75db7f..b9c8158 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -16,7 +16,9 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/serial_reg.h>
 #include <linux/kallsyms.h>
 #include <linux/of.h>
@@ -55,7 +57,8 @@ static void __iomem *base;
 static unsigned long tclk;
 static const struct power_off_cfg *cfg;
 
-static void qnap_power_off(void)
+static int qnap_power_off(struct notifier_block *this, unsigned long unused1,
+			  void *unused2)
 {
 	const unsigned divisor = ((tclk + (8 * cfg->baud)) / (16 * cfg->baud));
 
@@ -72,14 +75,20 @@ static void qnap_power_off(void)
 
 	/* send the power-off command to PIC */
 	writel(cfg->cmd, UART1_REG(TX));
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block qnap_power_off_nb = {
+	.notifier_call = qnap_power_off,
+	.priority = POWER_OFF_PRIORITY_DEFAULT,
+};
+
 static int qnap_power_off_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	struct clk *clk;
-	char symname[KSYM_NAME_LEN];
 
 	const struct of_device_id *match =
 		of_match_node(qnap_power_off_of_match_table, np);
@@ -106,28 +115,11 @@ static int qnap_power_off_probe(struct platform_device *pdev)
 
 	tclk = clk_get_rate(clk);
 
-	/* Check that nothing else has already setup a handler */
-	if (pm_power_off) {
-		lookup_symbol_name((ulong)pm_power_off, symname);
-		dev_err(&pdev->dev,
-			"pm_power_off already claimed %p %s",
-			pm_power_off, symname);
-		return -EBUSY;
-	}
-	pm_power_off = qnap_power_off;
-
-	return 0;
-}
-
-static int qnap_power_off_remove(struct platform_device *pdev)
-{
-	pm_power_off = NULL;
-	return 0;
+	return devm_register_power_off_handler(&pdev->dev, &qnap_power_off_nb);
 }
 
 static struct platform_driver qnap_power_off_driver = {
 	.probe	= qnap_power_off_probe,
-	.remove	= qnap_power_off_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "qnap_power_off",
-- 
1.9.1

