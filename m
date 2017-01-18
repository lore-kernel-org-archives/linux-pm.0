From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 5/7] power: bq24190_charger: Call power_supply_changed() for relevant component
Date: Wed, 18 Jan 2017 09:26:52 -0800
Message-ID: <20170118172654.19416-6-liam@networkimprov.net>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170118172654.19416-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35738 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdARR2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 12:28:34 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so1514483pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2017 09:28:34 -0800 (PST)
In-Reply-To: <20170118172654.19416-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

We wrongly get uevents for bq24190-charger and bq24190-battery on every
register change.

Fix by checking the association with charger and battery before
emitting uevent(s).

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Mark Greer <mgreer@animalcreek.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 50 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 62194d8..ba5a5b2 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -159,7 +159,6 @@ struct bq24190_dev_info {
 	unsigned int			gpio_int;
 	unsigned int			irq;
 	struct mutex			f_reg_lock;
-	bool				first_time;
 	bool				charger_health_valid;
 	bool				battery_health_valid;
 	bool				battery_status_valid;
@@ -1197,7 +1196,10 @@ static const struct power_supply_desc bq24190_battery_desc = {
 static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 {
 	struct bq24190_dev_info *bdi = data;
-	bool alert_userspace = false;
+	const u8 battery_mask_ss = BQ24190_REG_SS_CHRG_STAT_MASK;
+	const u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK
+				| BQ24190_REG_F_NTC_FAULT_MASK;
+	bool alert_charger = false, alert_battery = false;
 	u8 ss_reg = 0, f_reg = 0;
 	int ret;
 
@@ -1225,8 +1227,12 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 					ret);
 		}
 
+		if ((bdi->ss_reg & battery_mask_ss) != (ss_reg & battery_mask_ss))
+			alert_battery = true;
+		if ((bdi->ss_reg & ~battery_mask_ss) != (ss_reg & ~battery_mask_ss))
+			alert_charger = true;
+
 		bdi->ss_reg = ss_reg;
-		alert_userspace = true;
 	}
 
 	mutex_lock(&bdi->f_reg_lock);
@@ -1239,33 +1245,23 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	}
 
 	if (f_reg != bdi->f_reg) {
+		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
+			alert_battery = true;
+		if ((bdi->f_reg & ~battery_mask_f) != (f_reg & ~battery_mask_f))
+			alert_charger = true;
+
 		bdi->f_reg = f_reg;
 		bdi->charger_health_valid = true;
 		bdi->battery_health_valid = true;
 		bdi->battery_status_valid = true;
-
-		alert_userspace = true;
 	}
 
 	mutex_unlock(&bdi->f_reg_lock);
 
-	/*
-	 * Sometimes bq24190 gives a steady trickle of interrupts even
-	 * though the watchdog timer is turned off and neither the STATUS
-	 * nor FAULT registers have changed.  Weed out these sprurious
-	 * interrupts so userspace isn't alerted for no reason.
-	 * In addition, the chip always generates an interrupt after
-	 * register reset so we should ignore that one (the very first
-	 * interrupt received).
-	 */
-	if (alert_userspace) {
-		if (!bdi->first_time) {
-			power_supply_changed(bdi->charger);
-			power_supply_changed(bdi->battery);
-		} else {
-			bdi->first_time = false;
-		}
-	}
+	if (alert_charger)
+		power_supply_changed(bdi->charger);
+	if (alert_battery)
+		power_supply_changed(bdi->battery);
 
 out:
 	pm_runtime_put_sync(bdi->dev);
@@ -1300,6 +1296,10 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 		goto out;
 
 	ret = bq24190_set_mode_host(bdi);
+	if (ret < 0)
+		goto out;
+
+	ret = bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 out:
 	pm_runtime_put_sync(bdi->dev);
 	return ret;
@@ -1375,7 +1375,8 @@ static int bq24190_probe(struct i2c_client *client,
 	bdi->model = id->driver_data;
 	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
 	mutex_init(&bdi->f_reg_lock);
-	bdi->first_time = true;
+	bdi->f_reg = 0;
+	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
 	bdi->charger_health_valid = false;
 	bdi->battery_health_valid = false;
 	bdi->battery_status_valid = false;
@@ -1491,13 +1492,16 @@ static int bq24190_pm_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 
+	bdi->f_reg = 0;
+	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
 	bdi->charger_health_valid = false;
 	bdi->battery_health_valid = false;
 	bdi->battery_status_valid = false;
 
 	pm_runtime_get_sync(bdi->dev);
 	bq24190_register_reset(bdi);
 	bq24190_set_mode_host(bdi);
+	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 	pm_runtime_put_sync(bdi->dev);
 
 	/* Things may have changed while suspended so alert upper layer */
