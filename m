From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 17/47] mfd: tps65910: Register with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:24 -0700
Message-ID: <1414425354-10359-18-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use dev_warn instead of dev_err

 drivers/mfd/tps65910.c       | 27 ++++++++++++++++++---------
 include/linux/mfd/tps65910.h |  3 +++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 7612d89..3c94dbf 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -23,6 +23,8 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/core.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/mfd/tps65910.h>
 #include <linux/of.h>
@@ -437,19 +439,20 @@ struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 }
 #endif
 
-static struct i2c_client *tps65910_i2c_client;
-static void tps65910_power_off(void)
+static int tps65910_power_off(struct notifier_block *this,
+			      unsigned long unused1, void *unused2)
 {
-	struct tps65910 *tps65910;
-
-	tps65910 = dev_get_drvdata(&tps65910_i2c_client->dev);
+	struct tps65910 *tps65910 = container_of(this, struct tps65910,
+						 power_off_nb);
 
 	if (tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
 			DEVCTRL_PWR_OFF_MASK) < 0)
-		return;
+		return NOTIFY_DONE;
 
 	tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
 			DEVCTRL_DEV_ON_MASK);
+
+	return NOTIFY_DONE;
 }
 
 static int tps65910_i2c_probe(struct i2c_client *i2c,
@@ -505,9 +508,13 @@ static int tps65910_i2c_probe(struct i2c_client *i2c,
 	tps65910_ck32k_init(tps65910, pmic_plat_data);
 	tps65910_sleepinit(tps65910, pmic_plat_data);
 
-	if (pmic_plat_data->pm_off && !pm_power_off) {
-		tps65910_i2c_client = i2c;
-		pm_power_off = tps65910_power_off;
+	if (pmic_plat_data->pm_off) {
+		tps65910->power_off_nb.notifier_call = tps65910_power_off;
+		tps65910->power_off_nb.priority = POWER_OFF_PRIORITY_LOW;
+		ret = register_power_off_handler(&tps65910->power_off_nb);
+		if (ret)
+			dev_warn(&i2c->dev,
+				 "failed to register power-off handler\n");
 	}
 
 	ret = mfd_add_devices(tps65910->dev, -1,
@@ -527,6 +534,8 @@ static int tps65910_i2c_remove(struct i2c_client *i2c)
 {
 	struct tps65910 *tps65910 = i2c_get_clientdata(i2c);
 
+	unregister_power_off_handler(&tps65910->power_off_nb);
+
 	tps65910_irq_exit(tps65910);
 	mfd_remove_devices(tps65910->dev);
 
diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
index 6483a6f..94876c4 100644
--- a/include/linux/mfd/tps65910.h
+++ b/include/linux/mfd/tps65910.h
@@ -905,6 +905,9 @@ struct tps65910 {
 	/* IRQ Handling */
 	int chip_irq;
 	struct regmap_irq_chip_data *irq_data;
+
+	/* Power-off handling */
+	struct notifier_block power_off_nb;
 };
 
 struct tps65910_platform_data {
-- 
1.9.1
