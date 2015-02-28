From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3] power: bq27x00_battery: add bq27510 support
Date: Sat, 28 Feb 2015 18:59:28 +0100
Message-ID: <1425146368-17167-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55862 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751837AbbB1R7h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 28 Feb 2015 12:59:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Add support for bq27510 to the bq27x00 driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v3:
 - rebased on git://git.infradead.org/battery-2.6.git branch/master

Changes in v2:
 - corrected the bq27x00_battery_read_cyct changes

 drivers/power/bq27x00_battery.c | 50 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 3cd8c68e2bdb..ba08b5926bfd 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -21,6 +21,7 @@
  * http://focus.ti.com/docs/prod/folders/print/bq27500.html
  * http://www.ti.com/product/bq27425-g1
  * http://www.ti.com/product/BQ27742-G1
+ * http://www.ti.com/product/BQ27510-G3
  */
 
 #include <linux/device.h>
@@ -71,6 +72,10 @@
 
 #define BQ27742_POWER_AVG		0x76
 
+#define BQ27510_REG_SOC			0x20
+#define BQ27510_REG_DCAP		0x2E /* Design capacity */
+#define BQ27510_REG_CYCT		0x1E /* Cycle count total */
+
 /* bq27425 register addresses are same as bq27x00 addresses minus 4 */
 #define BQ27425_REG_OFFSET		0x04
 #define BQ27425_REG_SOC		(0x1C + BQ27425_REG_OFFSET)
@@ -84,7 +89,7 @@ struct bq27x00_access_methods {
 	int (*read)(struct bq27x00_device_info *di, u8 reg, bool single);
 };
 
-enum bq27x00_chip { BQ27000, BQ27500, BQ27425, BQ27742};
+enum bq27x00_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510};
 
 struct bq27x00_reg_cache {
 	int temperature;
@@ -171,6 +176,24 @@ static enum power_supply_property bq27742_battery_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 };
 
+static enum power_supply_property bq27510_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_HEALTH,
+};
+
 static unsigned int poll_interval = 360;
 module_param(poll_interval, uint, 0644);
 MODULE_PARM_DESC(poll_interval, "battery poll interval in seconds - " \
@@ -195,7 +218,8 @@ static inline int bq27x00_read(struct bq27x00_device_info *di, u8 reg,
  */
 static bool bq27xxx_is_chip_version_higher(struct bq27x00_device_info *di)
 {
-	if (di->chip == BQ27425 || di->chip == BQ27500 || di->chip == BQ27742)
+	if (di->chip == BQ27425 || di->chip == BQ27500 || di->chip == BQ27742
+	    || di->chip == BQ27510)
 		return true;
 	return false;
 }
@@ -210,6 +234,8 @@ static int bq27x00_battery_read_rsoc(struct bq27x00_device_info *di)
 
 	if (di->chip == BQ27500 || di->chip == BQ27742)
 		rsoc = bq27x00_read(di, BQ27500_REG_SOC, false);
+	else if (di->chip == BQ27510)
+		rsoc = bq27x00_read(di, BQ27510_REG_SOC, false);
 	else if (di->chip == BQ27425)
 		rsoc = bq27x00_read(di, BQ27425_REG_SOC, false);
 	else
@@ -283,6 +309,8 @@ static int bq27x00_battery_read_ilmd(struct bq27x00_device_info *di)
 	if (bq27xxx_is_chip_version_higher(di)) {
 		if (di->chip == BQ27425)
 			ilmd = bq27x00_read(di, BQ27425_REG_DCAP, false);
+		else if (di->chip == BQ27510)
+			ilmd = bq27x00_read(di, BQ27510_REG_DCAP, false);
 		else
 			ilmd = bq27x00_read(di, BQ27500_REG_DCAP, false);
 	} else
@@ -351,7 +379,10 @@ static int bq27x00_battery_read_cyct(struct bq27x00_device_info *di)
 {
 	int cyct;
 
-	cyct = bq27x00_read(di, BQ27x00_REG_CYCT, false);
+	if (di->chip == BQ27510)
+		cyct = bq27x00_read(di, BQ27510_REG_CYCT, false);
+	else
+		cyct = bq27x00_read(di, BQ27x00_REG_CYCT, false);
 	if (cyct < 0)
 		dev_err(di->dev, "error reading cycle count total\n");
 
@@ -422,6 +453,10 @@ static int bq27x00_battery_read_health(struct bq27x00_device_info *di)
 		else
 			tval = POWER_SUPPLY_HEALTH_GOOD;
 		return tval;
+	} else if (di->chip == BQ27510) {
+		if (tval & BQ27500_FLAG_OTC)
+			return POWER_SUPPLY_HEALTH_OVERHEAT;
+		return POWER_SUPPLY_HEALTH_GOOD;
 	} else {
 		if (tval & BQ27000_FLAG_EDV1)
 			tval = POWER_SUPPLY_HEALTH_DEAD;
@@ -437,6 +472,7 @@ static void bq27x00_update(struct bq27x00_device_info *di)
 {
 	struct bq27x00_reg_cache cache = {0, };
 	bool is_bq27500 = di->chip == BQ27500;
+	bool is_bq27510 = di->chip == BQ27510;
 	bool is_bq27425 = di->chip == BQ27425;
 	bool is_bq27742 = di->chip == BQ27742;
 	bool flags_1b = !(is_bq27500 || is_bq27742);
@@ -446,7 +482,7 @@ static void bq27x00_update(struct bq27x00_device_info *di)
 		/* read error */
 		cache.flags = -1;
 	if (cache.flags >= 0) {
-		if (!is_bq27500 && !is_bq27425 && !is_bq27742
+		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
 				&& (cache.flags & BQ27000_FLAG_CI)) {
 			dev_info(di->dev, "battery is not calibrated! ignoring capacity values\n");
 			cache.capacity = -ENODATA;
@@ -458,7 +494,7 @@ static void bq27x00_update(struct bq27x00_device_info *di)
 			cache.health = -ENODATA;
 		} else {
 			cache.capacity = bq27x00_battery_read_rsoc(di);
-			if (is_bq27742)
+			if (is_bq27742 || is_bq27510)
 				cache.time_to_empty =
 					bq27x00_battery_read_time(di,
 							BQ27x00_REG_TTE);
@@ -742,6 +778,9 @@ static int bq27x00_powersupply_init(struct bq27x00_device_info *di)
 	} else if (di->chip == BQ27742) {
 		di->bat.properties = bq27742_battery_props;
 		di->bat.num_properties = ARRAY_SIZE(bq27742_battery_props);
+	} else if (di->chip == BQ27510) {
+		di->bat.properties = bq27510_battery_props;
+		di->bat.num_properties = ARRAY_SIZE(bq27510_battery_props);
 	} else {
 		di->bat.properties = bq27x00_battery_props;
 		di->bat.num_properties = ARRAY_SIZE(bq27x00_battery_props);
@@ -899,6 +938,7 @@ static const struct i2c_device_id bq27x00_id[] = {
 	{ "bq27500", BQ27500 },
 	{ "bq27425", BQ27425 },
 	{ "bq27742", BQ27742 },
+	{ "bq27510", BQ27510 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27x00_id);
-- 
2.1.0

