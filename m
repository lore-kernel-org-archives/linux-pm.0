From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 7/7] power: bq24190_charger: Handle fault before status on interrupt
Date: Wed, 18 Jan 2017 09:26:54 -0800
Message-ID: <20170118172654.19416-8-liam@networkimprov.net>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170118172654.19416-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36201 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdARR2r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 12:28:47 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so1858452pgf.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2017 09:28:42 -0800 (PST)
In-Reply-To: <20170118172654.19416-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Reading both fault and status registers and logging any fault should
take priority over handling status register update.

Fix by moving the status handling to later in interrupt routine.

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Mark Greer <mgreer@animalcreek.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index a36788c..1cb7d14 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1175,29 +1175,6 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 		goto out;
 	}
 
-	if (ss_reg != bdi->ss_reg) {
-		/*
-		 * The device is in host mode so when PG_STAT goes from 1->0
-		 * (i.e., power removed) HIZ needs to be disabled.
-		 */
-		if ((bdi->ss_reg & BQ24190_REG_SS_PG_STAT_MASK) &&
-				!(ss_reg & BQ24190_REG_SS_PG_STAT_MASK)) {
-			ret = bq24190_write_mask(bdi, BQ24190_REG_ISC,
-					BQ24190_REG_ISC_EN_HIZ_MASK,
-					BQ24190_REG_ISC_EN_HIZ_SHIFT,
-					0);
-			if (ret < 0)
-				dev_err(bdi->dev, "Can't access ISC reg: %d\n",
-					ret);
-		}
-
-		if ((bdi->ss_reg & battery_mask_ss) != (ss_reg & battery_mask_ss))
-			alert_battery = true;
-		if ((bdi->ss_reg & ~battery_mask_ss) != (ss_reg & ~battery_mask_ss))
-			alert_charger = true;
-		bdi->ss_reg = ss_reg;
-	}
-
 	i = 0;
 	do {
 		ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
@@ -1224,6 +1201,29 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 		mutex_unlock(&bdi->f_reg_lock);
 	}
 
+	if (ss_reg != bdi->ss_reg) {
+		/*
+		 * The device is in host mode so when PG_STAT goes from 1->0
+		 * (i.e., power removed) HIZ needs to be disabled.
+		 */
+		if ((bdi->ss_reg & BQ24190_REG_SS_PG_STAT_MASK) &&
+				!(ss_reg & BQ24190_REG_SS_PG_STAT_MASK)) {
+			ret = bq24190_write_mask(bdi, BQ24190_REG_ISC,
+					BQ24190_REG_ISC_EN_HIZ_MASK,
+					BQ24190_REG_ISC_EN_HIZ_SHIFT,
+					0);
+			if (ret < 0)
+				dev_err(bdi->dev, "Can't access ISC reg: %d\n",
+					ret);
+		}
+
+		if ((bdi->ss_reg & battery_mask_ss) != (ss_reg & battery_mask_ss))
+			alert_battery = true;
+		if ((bdi->ss_reg & ~battery_mask_ss) != (ss_reg & ~battery_mask_ss))
+			alert_charger = true;
+		bdi->ss_reg = ss_reg;
+	}
+
 	if (alert_charger)
 		power_supply_changed(bdi->charger);
 	if (alert_battery)
