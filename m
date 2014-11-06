From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 13/48] mfd: max8907: Register with kernel power-off handler
Date: Thu,  6 Nov 2014 08:42:57 -0800
Message-ID: <1415292213-28652-14-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56190 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbaKFQoN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 11:44:13 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmQAP-000TPx-8O
	for linux-pm@vger.kernel.org; Thu, 06 Nov 2014 16:44:13 +0000
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Note that this patch fixes a problem on driver unload as side effect:
The old code did not restore or clean up pm_power_off on remove,
meaning the pointer was left in an undefined state.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
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
- Use dev_warn instead of dev_err

 drivers/mfd/max8907.c       | 21 +++++++++++++++------
 include/linux/mfd/max8907.h |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 232749c..84f8afd 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -177,10 +178,12 @@ static const struct regmap_irq_chip max8907_rtc_irq_chip = {
 	.num_irqs = ARRAY_SIZE(max8907_rtc_irqs),
 };
 
-static struct max8907 *max8907_pm_off;
-static void max8907_power_off(void)
+static void max8907_power_off(struct power_off_handler_block *this)
 {
-	regmap_update_bits(max8907_pm_off->regmap_gen, MAX8907_REG_RESET_CNFG,
+	struct max8907 *max8907 = container_of(this, struct max8907,
+					       power_off_hb);
+
+	regmap_update_bits(max8907->regmap_gen, MAX8907_REG_RESET_CNFG,
 			MAX8907_MASK_POWER_OFF, MAX8907_MASK_POWER_OFF);
 }
 
@@ -267,9 +270,13 @@ static int max8907_i2c_probe(struct i2c_client *i2c,
 		goto err_add_devices;
 	}
 
-	if (pm_off && !pm_power_off) {
-		max8907_pm_off = max8907;
-		pm_power_off = max8907_power_off;
+	if (pm_off) {
+		max8907->power_off_hb.handler = max8907_power_off;
+		max8907->power_off_hb.priority = POWER_OFF_PRIORITY_LOW;
+		ret = register_power_off_handler(&max8907->power_off_hb);
+		if (ret)
+			dev_warn(&i2c->dev,
+				 "Failed to register power-off handler");
 	}
 
 	return 0;
@@ -293,6 +300,8 @@ static int max8907_i2c_remove(struct i2c_client *i2c)
 {
 	struct max8907 *max8907 = i2c_get_clientdata(i2c);
 
+	unregister_power_off_handler(&max8907->power_off_hb);
+
 	mfd_remove_devices(max8907->dev);
 
 	regmap_del_irq_chip(max8907->i2c_gen->irq, max8907->irqc_rtc);
diff --git a/include/linux/mfd/max8907.h b/include/linux/mfd/max8907.h
index b06f7a6..18a4c68 100644
--- a/include/linux/mfd/max8907.h
+++ b/include/linux/mfd/max8907.h
@@ -247,6 +247,7 @@ struct max8907 {
 	struct regmap_irq_chip_data	*irqc_chg;
 	struct regmap_irq_chip_data	*irqc_on_off;
 	struct regmap_irq_chip_data	*irqc_rtc;
+	struct power_off_handler_block	power_off_hb;
 };
 
 #endif
-- 
1.9.1

