From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 6/7] power: bq24190_charger: Don't read fault register outside irq_handle_thread()
Date: Wed, 18 Jan 2017 09:26:53 -0800
Message-ID: <20170118172654.19416-7-liam@networkimprov.net>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170118172654.19416-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34076 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdARR2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 12:28:37 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so1517662pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2017 09:28:37 -0800 (PST)
In-Reply-To: <20170118172654.19416-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Caching the fault register after a single I2C read may not keep an accurate
value.

Fix by doing two reads in irq_handle_thread() and using the cached value
elsewhere. If a safety timer fault later clears itself, we apparently don't get
an interrupt (INT), however other interrupts would refresh the register cache.

>From the data sheet: "When a fault occurs, the charger device sends out INT
 and keeps the fault state in REG09 until the host reads the fault register.
 Before the host reads REG09 and all the faults are cleared, the charger
 device would not send any INT upon new faults. In order to read the
 current fault status, the host has to read REG09 two times consecutively.
 The 1st reads fault register status from the last read [1] and the 2nd reads
 the current fault register status."

[1] presumably a typo; should be "last fault"

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Mark Greer <mgreer@animalcreek.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 93 ++++++++++------------------------
 1 file changed, 26 insertions(+), 67 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index ba5a5b2..a36788c 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -144,10 +144,7 @@
  * so the first read after a fault returns the latched value and subsequent
  * reads return the current value.  In order to return the fault status
  * to the user, have the interrupt handler save the reg's value and retrieve
- * it in the appropriate health/status routine.  Each routine has its own
- * flag indicating whether it should use the value stored by the last run
- * of the interrupt handler or do an actual reg read.  That way each routine
- * can report back whatever fault may have occured.
+ * it in the appropriate health/status routine.
  */
 struct bq24190_dev_info {
 	struct i2c_client		*client;
@@ -159,9 +156,6 @@ struct bq24190_dev_info {
 	unsigned int			gpio_int;
 	unsigned int			irq;
 	struct mutex			f_reg_lock;
-	bool				charger_health_valid;
-	bool				battery_health_valid;
-	bool				battery_status_valid;
 	u8				f_reg;
 	u8				ss_reg;
 	u8				watchdog;
@@ -635,21 +629,11 @@ static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
 		union power_supply_propval *val)
 {
 	u8 v;
-	int health, ret;
+	int health;
 
 	mutex_lock(&bdi->f_reg_lock);
-
-	if (bdi->charger_health_valid) {
-		v = bdi->f_reg;
-		bdi->charger_health_valid = false;
-		mutex_unlock(&bdi->f_reg_lock);
-	} else {
-		mutex_unlock(&bdi->f_reg_lock);
-
-		ret = bq24190_read(bdi, BQ24190_REG_F, &v);
-		if (ret < 0)
-			return ret;
-	}
+	v = bdi->f_reg;
+	mutex_unlock(&bdi->f_reg_lock);
 
 	if (v & BQ24190_REG_F_BOOST_FAULT_MASK) {
 		/*
@@ -936,18 +920,8 @@ static int bq24190_battery_get_status(struct bq24190_dev_info *bdi,
 	int status, ret;
 
 	mutex_lock(&bdi->f_reg_lock);
-
-	if (bdi->battery_status_valid) {
-		chrg_fault = bdi->f_reg;
-		bdi->battery_status_valid = false;
-		mutex_unlock(&bdi->f_reg_lock);
-	} else {
-		mutex_unlock(&bdi->f_reg_lock);
-
-		ret = bq24190_read(bdi, BQ24190_REG_F, &chrg_fault);
-		if (ret < 0)
-			return ret;
-	}
+	chrg_fault = bdi->f_reg;
+	mutex_unlock(&bdi->f_reg_lock);
 
 	chrg_fault &= BQ24190_REG_F_CHRG_FAULT_MASK;
 	chrg_fault >>= BQ24190_REG_F_CHRG_FAULT_SHIFT;
@@ -995,21 +969,11 @@ static int bq24190_battery_get_health(struct bq24190_dev_info *bdi,
 		union power_supply_propval *val)
 {
 	u8 v;
-	int health, ret;
+	int health;
 
 	mutex_lock(&bdi->f_reg_lock);
-
-	if (bdi->battery_health_valid) {
-		v = bdi->f_reg;
-		bdi->battery_health_valid = false;
-		mutex_unlock(&bdi->f_reg_lock);
-	} else {
-		mutex_unlock(&bdi->f_reg_lock);
-
-		ret = bq24190_read(bdi, BQ24190_REG_F, &v);
-		if (ret < 0)
-			return ret;
-	}
+	v = bdi->f_reg;
+	mutex_unlock(&bdi->f_reg_lock);
 
 	if (v & BQ24190_REG_F_BAT_FAULT_MASK) {
 		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
@@ -1201,7 +1165,7 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 				| BQ24190_REG_F_NTC_FAULT_MASK;
 	bool alert_charger = false, alert_battery = false;
 	u8 ss_reg = 0, f_reg = 0;
-	int ret;
+	int i, ret;
 
 	pm_runtime_get_sync(bdi->dev);
 
@@ -1231,33 +1195,35 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 			alert_battery = true;
 		if ((bdi->ss_reg & ~battery_mask_ss) != (ss_reg & ~battery_mask_ss))
 			alert_charger = true;
-
 		bdi->ss_reg = ss_reg;
 	}
 
-	mutex_lock(&bdi->f_reg_lock);
-
-	ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
-	if (ret < 0) {
-		mutex_unlock(&bdi->f_reg_lock);
-		dev_err(bdi->dev, "Can't read F reg: %d\n", ret);
-		goto out;
-	}
+	i = 0;
+	do {
+		ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
+		if (ret < 0) {
+			dev_err(bdi->dev, "Can't read F reg: %d\n", ret);
+			goto out;
+		}
+	} while (f_reg && ++i < 2);
 
 	if (f_reg != bdi->f_reg) {
+		dev_info(bdi->dev,
+			"Fault: boost %d, charge %d, battery %d, ntc %d\n",
+			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
+			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
+			!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
+			!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
+
+		mutex_lock(&bdi->f_reg_lock);
 		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
 			alert_battery = true;
 		if ((bdi->f_reg & ~battery_mask_f) != (f_reg & ~battery_mask_f))
 			alert_charger = true;
-
 		bdi->f_reg = f_reg;
-		bdi->charger_health_valid = true;
-		bdi->battery_health_valid = true;
-		bdi->battery_status_valid = true;
+		mutex_unlock(&bdi->f_reg_lock);
 	}
 
-	mutex_unlock(&bdi->f_reg_lock);
-
 	if (alert_charger)
 		power_supply_changed(bdi->charger);
 	if (alert_battery)
@@ -1377,9 +1343,6 @@ static int bq24190_probe(struct i2c_client *client,
 	mutex_init(&bdi->f_reg_lock);
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
-	bdi->charger_health_valid = false;
-	bdi->battery_health_valid = false;
-	bdi->battery_status_valid = false;
 
 	i2c_set_clientdata(client, bdi);
 
@@ -1494,9 +1457,6 @@ static int bq24190_pm_resume(struct device *dev)
 
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
-	bdi->charger_health_valid = false;
-	bdi->battery_health_valid = false;
-	bdi->battery_status_valid = false;
 
 	pm_runtime_get_sync(bdi->dev);
 	bq24190_register_reset(bdi);
