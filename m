From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 19/48] mfd: rk808: Register power-off handler with kernel power-off handler
Date: Thu,  6 Nov 2014 08:43:03 -0800
Message-ID: <1415292213-28652-20-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Zhang Qing <zhangqing@rock-chips.com>
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
- New patch

 drivers/mfd/rk808.c       | 26 ++++++++++++--------------
 include/linux/mfd/rk808.h |  2 ++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index bd02150..93ffcf0 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -21,6 +21,7 @@
 #include <linux/mfd/rk808.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 struct rk808_reg_data {
@@ -147,23 +148,16 @@ static struct regmap_irq_chip rk808_irq_chip = {
 	.init_ack_masked = true,
 };
 
-static struct i2c_client *rk808_i2c_client;
-static void rk808_device_shutdown(void)
+static void rk808_device_shutdown(struct power_off_handler_block *this)
 {
+	struct rk808 *rk808 = container_of(this, struct rk808, power_off_hb);
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
 }
 
 static int rk808_probe(struct i2c_client *client,
@@ -222,9 +216,14 @@ static int rk808_probe(struct i2c_client *client,
 
 	pm_off = of_property_read_bool(np,
 				"rockchip,system-power-controller");
-	if (pm_off && !pm_power_off) {
-		rk808_i2c_client = client;
-		pm_power_off = rk808_device_shutdown;
+	if (pm_off) {
+		rk808->power_off_hb.handler = rk808_device_shutdown;
+		rk808->power_off_hb.priority = POWER_OFF_PRIORITY_LOW;
+		ret = devm_register_power_off_handler(&client->dev,
+						      &rk808->power_off_hb);
+		if (ret)
+			dev_warn(&client->dev,
+				 "Failed to register power-off handler\n");
 	}
 
 	return 0;
@@ -240,7 +239,6 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 	mfd_remove_devices(&client->dev);
-	pm_power_off = NULL;
 
 	return 0;
 }
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index fb09312..a6619f2 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -19,6 +19,7 @@
 #ifndef __LINUX_REGULATOR_rk808_H
 #define __LINUX_REGULATOR_rk808_H
 
+#include <linux/pm.h>
 #include <linux/regulator/machine.h>
 #include <linux/regmap.h>
 
@@ -192,5 +193,6 @@ struct rk808 {
 	struct i2c_client *i2c;
 	struct regmap_irq_chip_data *irq_data;
 	struct regmap *regmap;
+	struct power_off_handler_block power_off_hb;
 };
 #endif /* __LINUX_REGULATOR_rk808_H */
-- 
1.9.1
