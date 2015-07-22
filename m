From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 8/8] power: bq27xxx_battery: Cleanup health checking
Date: Wed, 22 Jul 2015 16:52:00 -0500
Message-ID: <1437601920-13045-9-git-send-email-afd@ti.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34001 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376AbbGVWAt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 18:00:49 -0400
In-Reply-To: <1437601920-13045-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

Reorganize the logic checking battery health and under temperature
condition checking.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27xxx_battery.c | 62 +++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index f148222..6775f65 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -54,6 +54,8 @@
 #define BQ27XXX_FLAG_FC		BIT(9)
 #define BQ27XXX_FLAG_OTD	BIT(14)
 #define BQ27XXX_FLAG_OTC	BIT(15)
+#define BQ27XXX_FLAG_UT		BIT(14)
+#define BQ27XXX_FLAG_OT		BIT(15)
 
 /* BQ27000 has different layout for Flags register */
 #define BQ27000_FLAG_EDVF	BIT(0) /* Final End-of-Discharge-Voltage flag */
@@ -624,10 +626,34 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
  */
 static int bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 {
-	if (di->chip == BQ27500 || di->chip == BQ27541)
+	if (di->chip == BQ27500 || di->chip == BQ27541 || di->chip == BQ27545)
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
+	if (di->chip == BQ27530 || di->chip == BQ27421)
+		return flags & BQ27XXX_FLAG_OT;
+
+	return false;
+}
+
+/*
+ * Returns true if a battery under temperature condition is detected
+ */
+static int bq27xxx_battery_undertemp(struct bq27xxx_device_info *di, u16 flags)
+{
+	if (di->chip == BQ27530 || di->chip == BQ27421)
+			return flags & BQ27XXX_FLAG_UT;
+
+	return false;
+}
+
+/*
+ * Returns true if a low state of charge condition is detected
+ */
+static int bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
+{
+	if (di->chip == BQ27000 || di->chip == BQ27010)
+		return flags & (BQ27000_FLAG_EDV1 | BQ27000_FLAG_EDVF);
 	else
-		return flags & BQ27XXX_FLAG_OTC;
+		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
 }
 
 /*
@@ -636,29 +662,23 @@ static int bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
  */
 static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
-	u16 tval;
+	u16 flags;
 
-	tval = bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
-	if (tval < 0) {
-		dev_err(di->dev, "error reading flag register:%d\n", tval);
-		return tval;
+	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
+	if (flags < 0) {
+		dev_err(di->dev, "error reading flag register:%d\n", flags);
+		return flags;
 	}
 
-	if (di->chip == BQ27000 || di->chip == BQ27010) {
-		if (tval & BQ27000_FLAG_EDV1)
-			tval = POWER_SUPPLY_HEALTH_DEAD;
-		else
-			tval = POWER_SUPPLY_HEALTH_GOOD;
-	} else {
-		if (tval & BQ27XXX_FLAG_SOCF)
-			tval = POWER_SUPPLY_HEALTH_DEAD;
-		else if (bq27xxx_battery_overtemp(di, tval))
-			tval = POWER_SUPPLY_HEALTH_OVERHEAT;
-		else
-			tval = POWER_SUPPLY_HEALTH_GOOD;
-	}
+	/* Unlikely but important to return first */
+	if (bq27xxx_battery_overtemp(di, flags))
+		return POWER_SUPPLY_HEALTH_OVERHEAT;
+	if (bq27xxx_battery_undertemp(di, flags))
+		return POWER_SUPPLY_HEALTH_COLD;
+	if (bq27xxx_battery_dead(di, flags))
+		return POWER_SUPPLY_HEALTH_DEAD;
 
-	return tval;
+	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
 static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
-- 
1.9.1

