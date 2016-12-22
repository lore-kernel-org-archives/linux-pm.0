From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH 09/10] power: supplies: bq275xx: adds specific support for bq27520-g4 revision.
Date: Thu, 22 Dec 2016 12:22:22 +1100
Message-ID: <1482369743-79764-10-git-send-email-chris@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35384 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938631AbcLVBXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2016 20:23:36 -0500
Received: by mail-pg0-f65.google.com with SMTP id i5so8541174pgh.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2016 17:22:59 -0800 (PST)
In-Reply-To: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

This commit adds the BQ27520G4 chip definition to specifically match the
bq27520-G4 functionality as described in the datasheet.

tested: no

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/supply/bq27xxx_battery.c     | 40 +++++++++++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 ++
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index d36dc3a..c92c809 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -29,6 +29,7 @@
  * http://www.ti.com/product/bq27520-g1
  * http://www.ti.com/product/bq27520-g2
  * http://www.ti.com/product/bq27520-g3
+ * http://www.ti.com/product/bq27520-g4
  * http://www.ti.com/product/bq27530-g1
  * http://www.ti.com/product/bq27531-g1
  * http://www.ti.com/product/bq27541-g1
@@ -302,6 +303,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
 	},
+	[BQ27520G4] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = 0x28,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = 0x1c,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x1e,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x20,
+		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+	},
 	[BQ27530] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -582,6 +602,23 @@ static enum power_supply_property bq27520g3_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq27520g4_battery_props[] = {
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
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
 static enum power_supply_property bq27530_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -672,6 +709,7 @@ static struct {
 	BQ27XXX_PROP(BQ27520G1, bq27520g1_battery_props),
 	BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
 	BQ27XXX_PROP(BQ27520G3, bq27520g3_battery_props),
+	BQ27XXX_PROP(BQ27520G4, bq27520g4_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -925,7 +963,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 	if (di->chip == BQ275XX || di->chip == BQ27500 || di->chip == BQ27510G1
 			|| di->chip == BQ27510G2 || di->chip == BQ27510G3 || di->chip == BQ27541
 			|| di->chip == BQ27520G1 || di->chip == BQ27520G2 || di->chip == BQ27520G3
-			|| di->chip == BQ27545)
+			|| di->chip == BQ27520G4 || di->chip == BQ27545)
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
 	if (di->chip == BQ27530 || di->chip == BQ27421)
 		return flags & BQ27XXX_FLAG_OT;
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 899a846..3878da4 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -158,6 +158,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27520g1", BQ27520G1 },
 	{ "bq27520g2", BQ27520G2 },
 	{ "bq27520g3", BQ27520G3 },
+	{ "bq27520g4", BQ27520G4 },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
@@ -187,6 +188,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27520g1" },
 	{ .compatible = "ti,bq27520g2" },
 	{ .compatible = "ti,bq27520g3" },
+	{ .compatible = "ti,bq27520g4" },
 	{ .compatible = "ti,bq27530" },
 	{ .compatible = "ti,bq27531" },
 	{ .compatible = "ti,bq27541" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index e61f4fa..09af70d 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -12,6 +12,7 @@ enum bq27xxx_chip {
 	BQ27520G1, /* bq27520G1 */
 	BQ27520G2, /* bq27520G2 */
 	BQ27520G3, /* bq27520G3 */
+	BQ27520G4, /* bq27520G4 */
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
-- 
2.1.4

