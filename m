From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 19/47] mfd: rk808: Register poweroff handler with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:35 -0700
Message-ID: <1413864783-3271-20-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Zhang Qing <zhangqing@rock-chips.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- New patch

 drivers/mfd/rk808.c       | 30 ++++++++++++++++--------------
 include/linux/mfd/rk808.h |  2 ++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index bd02150..7f07279 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -21,6 +21,8 @@
 #include <linux/mfd/rk808.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 struct rk808_reg_data {
@@ -147,23 +149,19 @@ static struct regmap_irq_chip rk808_irq_chip = {
 	.init_ack_masked = true,
 };
 
-static struct i2c_client *rk808_i2c_client;
-static void rk808_device_shutdown(void)
+static int rk808_device_shutdown(struct notifier_block *this,
+				 unsigned long unused1, void *unused2)
 {
+	struct rk808 *rk808 = container_of(this, struct rk808, poweroff_nb);
 	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808) {
-		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk808, so do nothing here\n");
-		return;
-	}
 
 	ret = regmap_update_bits(rk808->regmap,
 				 RK808_DEVCTRL_REG,
 				 DEV_OFF_RST, DEV_OFF_RST);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+		dev_err(&rk808->i2c->dev, "power off error!\n");
+
+	return NOTIFY_DONE;
 }
 
 static int rk808_probe(struct i2c_client *client,
@@ -222,9 +220,14 @@ static int rk808_probe(struct i2c_client *client,
 
 	pm_off = of_property_read_bool(np,
 				"rockchip,system-power-controller");
-	if (pm_off && !pm_power_off) {
-		rk808_i2c_client = client;
-		pm_power_off = rk808_device_shutdown;
+	if (pm_off) {
+		rk808->poweroff_nb.notifier_call = rk808_device_shutdown;
+		rk808->poweroff_nb.priority = POWEROFF_PRIORITY_LOW;
+		ret = devm_register_power_off_handler(&client->dev,
+						      &rk808->poweroff_nb);
+		if (ret)
+			dev_warn(&client->dev,
+				 "Failed to register poweroff handler\n");
 	}
 
 	return 0;
@@ -240,7 +243,6 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 	mfd_remove_devices(&client->dev);
-	pm_power_off = NULL;
 
 	return 0;
 }
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index fb09312..abc80cc 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -19,6 +19,7 @@
 #ifndef __LINUX_REGULATOR_rk808_H
 #define __LINUX_REGULATOR_rk808_H
 
+#include <linux/notifier.h>
 #include <linux/regulator/machine.h>
 #include <linux/regmap.h>
 
@@ -192,5 +193,6 @@ struct rk808 {
 	struct i2c_client *i2c;
 	struct regmap_irq_chip_data *irq_data;
 	struct regmap *regmap;
+	struct notifier_block poweroff_nb;
 };
 #endif /* __LINUX_REGULATOR_rk808_H */
-- 
1.9.1
