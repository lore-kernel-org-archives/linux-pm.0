From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 10/47] mfd: axp20x: Register with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:17 -0700
Message-ID: <1414425354-10359-11-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49993 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaJ0P43 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 11:56:29 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Ximei-000bWO-MU
	for linux-pm@vger.kernel.org; Mon, 27 Oct 2014 15:56:28 +0000
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with a low priority value of 64 to reflect that
the original code only sets pm_power_off if it was not already set.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify powroff handler priority
- Use devm_register_power_off_handler
- Use dev_warn instead of dev_err

 drivers/mfd/axp20x.c       | 30 ++++++++++++++++--------------
 include/linux/mfd/axp20x.h |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 6231adb..f00db57 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -17,7 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/pm_runtime.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
@@ -150,11 +151,16 @@ static struct mfd_cell axp20x_cells[] = {
 	},
 };
 
-static struct axp20x_dev *axp20x_pm_power_off;
-static void axp20x_power_off(void)
+static int axp20x_power_off(struct notifier_block *this, unsigned long unused1,
+			    void *unused2)
+
 {
-	regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL,
-		     AXP20X_OFF);
+	struct axp20x_dev *axp20x = container_of(this, struct axp20x_dev,
+						 power_off_nb);
+
+	regmap_write(axp20x->regmap, AXP20X_OFF_CTRL, AXP20X_OFF);
+
+	return NOTIFY_DONE;
 }
 
 static int axp20x_i2c_probe(struct i2c_client *i2c,
@@ -204,10 +210,11 @@ static int axp20x_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (!pm_power_off) {
-		axp20x_pm_power_off = axp20x;
-		pm_power_off = axp20x_power_off;
-	}
+	axp20x->power_off_nb.notifier_call = axp20x_power_off;
+	axp20x->power_off_nb.priority = POWER_OFF_PRIORITY_LOW;
+	ret = devm_register_power_off_handler(&i2c->dev, &axp20x->power_off_nb);
+	if (ret)
+		dev_warn(&i2c->dev, "failed to register power-off handler\n");
 
 	dev_info(&i2c->dev, "AXP20X driver loaded\n");
 
@@ -218,11 +225,6 @@ static int axp20x_i2c_remove(struct i2c_client *i2c)
 {
 	struct axp20x_dev *axp20x = i2c_get_clientdata(i2c);
 
-	if (axp20x == axp20x_pm_power_off) {
-		axp20x_pm_power_off = NULL;
-		pm_power_off = NULL;
-	}
-
 	mfd_remove_devices(axp20x->dev);
 	regmap_del_irq_chip(axp20x->i2c_client->irq, axp20x->regmap_irqc);
 
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index d0e31a2..9b15482 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -175,6 +175,7 @@ struct axp20x_dev {
 	struct regmap			*regmap;
 	struct regmap_irq_chip_data	*regmap_irqc;
 	long				variant;
+	struct notifier_block		power_off_nb;
 };
 
 #endif /* __LINUX_MFD_AXP20X_H */
-- 
1.9.1

