From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 25/48] power/reset: qnap-poweroff: Register with kernel power-off handler
Date: Thu,  6 Nov 2014 08:43:09 -0800
Message-ID: <1415292213-28652-26-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

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
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use devm_register_power_off_handler
- Drop remove function since it is no longer needed

 drivers/power/reset/qnap-poweroff.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index a75db7f..0f39564 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/serial_reg.h>
 #include <linux/kallsyms.h>
 #include <linux/of.h>
@@ -55,7 +56,7 @@ static void __iomem *base;
 static unsigned long tclk;
 static const struct power_off_cfg *cfg;
 
-static void qnap_power_off(void)
+static void qnap_power_off(struct power_off_handler_block *this)
 {
 	const unsigned divisor = ((tclk + (8 * cfg->baud)) / (16 * cfg->baud));
 
@@ -74,12 +75,16 @@ static void qnap_power_off(void)
 	writel(cfg->cmd, UART1_REG(TX));
 }
 
+static struct power_off_handler_block qnap_power_off_hb = {
+	.handler = qnap_power_off,
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
@@ -106,28 +111,11 @@ static int qnap_power_off_probe(struct platform_device *pdev)
 
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
+	return devm_register_power_off_handler(&pdev->dev, &qnap_power_off_hb);
 }
 
 static struct platform_driver qnap_power_off_driver = {
 	.probe	= qnap_power_off_probe,
-	.remove	= qnap_power_off_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "qnap_power_off",
-- 
1.9.1
