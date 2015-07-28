From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 6/6] power: bq27xxx_battery: Cleanup health checking
Date: Tue, 28 Jul 2015 14:39:13 -0500
Message-ID: <1438112353-19704-7-git-send-email-afd@ti.com>
References: <1438112353-19704-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438112353-19704-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

Reorganize the logic checking battery health and add under temperature
condition checking.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27xxx_battery.c | 64 +++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index d03ed11..d7c2e7d 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -63,6 +63,8 @@
 #define BQ27XXX_FLAG_FC		BIT(9)
 #define BQ27XXX_FLAG_OTD	BIT(14)
 #define BQ27XXX_FLAG_OTC	BIT(15)
+#define BQ27XXX_FLAG_UT		BIT(14)
+#define BQ27XXX_FLAG_OT		BIT(15)
 
 /* BQ27000 has different layout for Flags register */
 #define BQ27000_FLAG_EDVF	BIT(0) /* Final End-of-Discharge-Voltage flag */
@@ -621,12 +623,36 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
 /*
  * Returns true if a battery over temperature condition is detected
  */
-static int bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
+static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
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
+static bool bq27xxx_battery_undertemp(struct bq27xxx_device_info *di, u16 flags)
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
+static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
+{
+	if (di->chip == BQ27000 || di->chip == BQ27010)
+		return flags & (BQ27000_FLAG_EDV1 | BQ27000_FLAG_EDVF);
 	else
-		return flags & BQ27XXX_FLAG_OTC;
+		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
 }
 
 /*
@@ -635,29 +661,23 @@ static int bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
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
+	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
+		return POWER_SUPPLY_HEALTH_OVERHEAT;
+	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
+		return POWER_SUPPLY_HEALTH_COLD;
+	if (unlikely(bq27xxx_battery_dead(di, flags)))
+		return POWER_SUPPLY_HEALTH_DEAD;
 
-	return tval;
+	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
 static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
-- 
1.9.1
