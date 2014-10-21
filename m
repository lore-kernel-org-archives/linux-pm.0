From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 11/47] mfd: retu: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:27 -0700
Message-ID: <1413864783-3271-12-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33599 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbaJUENk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 00:13:40 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgQpI-002d36-4v
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 04:13:40 +0000
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Use define to specify poweroff handler priority
- Use devm_register_power_off_handler
- Use dev_warn instead of dev_err

 drivers/mfd/retu-mfd.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index 663f8a3..3c720cb 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/retu.h>
@@ -43,6 +45,7 @@ struct retu_dev {
 	struct device			*dev;
 	struct mutex			mutex;
 	struct regmap_irq_chip_data	*irq_data;
+	struct notifier_block		poweroff_nb;
 };
 
 static struct resource retu_pwrbutton_res[] = {
@@ -81,9 +84,6 @@ static struct regmap_irq_chip retu_irq_chip = {
 	.ack_base	= RETU_REG_IDR,
 };
 
-/* Retu device registered for the power off. */
-static struct retu_dev *retu_pm_power_off;
-
 static struct resource tahvo_usb_res[] = {
 	{
 		.name	= "tahvo-usb",
@@ -165,12 +165,14 @@ int retu_write(struct retu_dev *rdev, u8 reg, u16 data)
 }
 EXPORT_SYMBOL_GPL(retu_write);
 
-static void retu_power_off(void)
+static int retu_power_off(struct notifier_block *this, unsigned long unused1,
+			  void *unused2)
 {
-	struct retu_dev *rdev = retu_pm_power_off;
+	struct retu_dev *rdev = container_of(this, struct retu_dev,
+					     poweroff_nb);
 	int reg;
 
-	mutex_lock(&retu_pm_power_off->mutex);
+	mutex_lock(&rdev->mutex);
 
 	/* Ignore power button state */
 	regmap_read(rdev->regmap, RETU_REG_CC1, &reg);
@@ -183,7 +185,9 @@ static void retu_power_off(void)
 	for (;;)
 		cpu_relax();
 
-	mutex_unlock(&retu_pm_power_off->mutex);
+	mutex_unlock(&rdev->mutex);
+
+	return NOTIFY_DONE;
 }
 
 static int retu_regmap_read(void *context, const void *reg, size_t reg_size,
@@ -279,9 +283,14 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 		return ret;
 	}
 
-	if (i2c->addr == 1 && !pm_power_off) {
-		retu_pm_power_off = rdev;
-		pm_power_off	  = retu_power_off;
+	if (i2c->addr == 1) {
+		rdev->poweroff_nb.notifier_call = retu_power_off;
+		rdev->poweroff_nb.priority = POWEROFF_PRIORITY_LOW;
+		ret = devm_register_power_off_handler(rdev->dev,
+						      &rdev->poweroff_nb);
+		if (ret)
+			dev_warn(rdev->dev,
+				 "Failed to register poweroff handler\n");
 	}
 
 	return 0;
@@ -291,10 +300,6 @@ static int retu_remove(struct i2c_client *i2c)
 {
 	struct retu_dev *rdev = i2c_get_clientdata(i2c);
 
-	if (retu_pm_power_off == rdev) {
-		pm_power_off	  = NULL;
-		retu_pm_power_off = NULL;
-	}
 	mfd_remove_devices(rdev->dev);
 	regmap_del_irq_chip(i2c->irq, rdev->irq_data);
 
-- 
1.9.1

