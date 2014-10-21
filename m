From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 24/47] power/reset: as3722-poweroff: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:40 -0700
Message-ID: <1413864783-3271-25-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Drop remove function since it is no longer needed.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Use define to specify poweroff handler priority
- Use devm_register_power_off_handler
- Drop remove function since it is no longer needed

 drivers/power/reset/as3722-poweroff.c | 39 ++++++++++++++---------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index 6849711..9f878e7 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -17,32 +17,33 @@
 
 #include <linux/mfd/as3722.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 
 struct as3722_poweroff {
 	struct device *dev;
 	struct as3722 *as3722;
+	struct notifier_block poweroff_nb;
 };
 
-static struct as3722_poweroff *as3722_pm_poweroff;
-
-static void as3722_pm_power_off(void)
+static int as3722_power_off(struct notifier_block *this, unsigned long unused1,
+			    void *unused2)
 {
+	struct as3722_poweroff *as3722_poweroff =
+		container_of(this, struct as3722_poweroff, poweroff_nb);
 	int ret;
 
-	if (!as3722_pm_poweroff) {
-		pr_err("AS3722 poweroff is not initialised\n");
-		return;
-	}
-
-	ret = as3722_update_bits(as3722_pm_poweroff->as3722,
+	ret = as3722_update_bits(as3722_poweroff->as3722,
 		AS3722_RESET_CONTROL_REG, AS3722_POWER_OFF, AS3722_POWER_OFF);
 	if (ret < 0)
-		dev_err(as3722_pm_poweroff->dev,
+		dev_err(as3722_poweroff->dev,
 			"RESET_CONTROL_REG update failed, %d\n", ret);
+
+	return NOTIFY_DONE;
 }
 
 static int as3722_poweroff_probe(struct platform_device *pdev)
@@ -63,20 +64,11 @@ static int as3722_poweroff_probe(struct platform_device *pdev)
 
 	as3722_poweroff->as3722 = dev_get_drvdata(pdev->dev.parent);
 	as3722_poweroff->dev = &pdev->dev;
-	as3722_pm_poweroff = as3722_poweroff;
-	if (!pm_power_off)
-		pm_power_off = as3722_pm_power_off;
-
-	return 0;
-}
-
-static int as3722_poweroff_remove(struct platform_device *pdev)
-{
-	if (pm_power_off == as3722_pm_power_off)
-		pm_power_off = NULL;
-	as3722_pm_poweroff = NULL;
+	as3722_poweroff->poweroff_nb.notifier_call = as3722_power_off;
+	as3722_poweroff->poweroff_nb.priority = POWEROFF_PRIORITY_LOW;
 
-	return 0;
+	return devm_register_power_off_handler(&pdev->dev,
+					      &as3722_poweroff->poweroff_nb);
 }
 
 static struct platform_driver as3722_poweroff_driver = {
@@ -85,7 +77,6 @@ static struct platform_driver as3722_poweroff_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = as3722_poweroff_probe,
-	.remove = as3722_poweroff_remove,
 };
 
 module_platform_driver(as3722_poweroff_driver);
-- 
1.9.1
