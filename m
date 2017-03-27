From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12 9/9] power: bq27xxx_battery: Remove duplicate register arrays
Date: Mon, 27 Mar 2017 00:41:59 -0700
Message-ID: <20170327074159.16213-6-liam@networkimprov.net>
References: <20170327074159.16213-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33498 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdC0HmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 03:42:23 -0400
Received: by mail-pg0-f68.google.com with SMTP id 79so10641712pgf.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2017 00:42:18 -0700 (PDT)
In-Reply-To: <20170327074159.16213-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

BQ2751X & BQ27510G3 are identical.
BQ27500 & BQ27510G1 & BQ27510G2 are identical.
Make BQ2751X & BQ27510G1/2 category members.
Remove the duplicate arrays, etc.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 144 +--------------------------------
 include/linux/power/bq27xxx_battery.h  |  12 +--
 2 files changed, 9 insertions(+), 147 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 95f86ad..c8c311f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -197,30 +197,6 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_DM_DATA] = 0x40,
 		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
-	[BQ2751X] = {
-		[BQ27XXX_REG_CTRL] = 0x00,
-		[BQ27XXX_REG_TEMP] = 0x06,
-		[BQ27XXX_REG_INT_TEMP] = 0x28,
-		[BQ27XXX_REG_VOLT] = 0x08,
-		[BQ27XXX_REG_AI] = 0x14,
-		[BQ27XXX_REG_FLAGS] = 0x0a,
-		[BQ27XXX_REG_TTE] = 0x16,
-		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_TTES] = 0x1a,
-		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_NAC] = 0x0c,
-		[BQ27XXX_REG_FCC] = 0x12,
-		[BQ27XXX_REG_CYCT] = 0x1e,
-		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_SOC] = 0x20,
-		[BQ27XXX_REG_DCAP] = 0x2e,
-		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
-		[BQ27XXX_DM_CTRL] = 0x61,
-		[BQ27XXX_DM_CLASS] = 0x3e,
-		[BQ27XXX_DM_BLOCK] = 0x3f,
-		[BQ27XXX_DM_DATA] = 0x40,
-		[BQ27XXX_DM_CKSUM] = 0x60,
-	},
 	[BQ27500] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -245,54 +221,6 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_DM_DATA] = 0x40,
 		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
-	[BQ27510G1] = {
-		[BQ27XXX_REG_CTRL] = 0x00,
-		[BQ27XXX_REG_TEMP] = 0x06,
-		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_VOLT] = 0x08,
-		[BQ27XXX_REG_AI] = 0x14,
-		[BQ27XXX_REG_FLAGS] = 0x0a,
-		[BQ27XXX_REG_TTE] = 0x16,
-		[BQ27XXX_REG_TTF] = 0x18,
-		[BQ27XXX_REG_TTES] = 0x1c,
-		[BQ27XXX_REG_TTECP] = 0x26,
-		[BQ27XXX_REG_NAC] = 0x0c,
-		[BQ27XXX_REG_FCC] = 0x12,
-		[BQ27XXX_REG_CYCT] = 0x2a,
-		[BQ27XXX_REG_AE] = 0x22,
-		[BQ27XXX_REG_SOC] = 0x2c,
-		[BQ27XXX_REG_DCAP] = 0x3c,
-		[BQ27XXX_REG_AP] = 0x24,
-		[BQ27XXX_DM_CTRL] = 0x61,
-		[BQ27XXX_DM_CLASS] = 0x3e,
-		[BQ27XXX_DM_BLOCK] = 0x3f,
-		[BQ27XXX_DM_DATA] = 0x40,
-		[BQ27XXX_DM_CKSUM] = 0x60,
-	},
-	[BQ27510G2] = {
-		[BQ27XXX_REG_CTRL] = 0x00,
-		[BQ27XXX_REG_TEMP] = 0x06,
-		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_VOLT] = 0x08,
-		[BQ27XXX_REG_AI] = 0x14,
-		[BQ27XXX_REG_FLAGS] = 0x0a,
-		[BQ27XXX_REG_TTE] = 0x16,
-		[BQ27XXX_REG_TTF] = 0x18,
-		[BQ27XXX_REG_TTES] = 0x1c,
-		[BQ27XXX_REG_TTECP] = 0x26,
-		[BQ27XXX_REG_NAC] = 0x0c,
-		[BQ27XXX_REG_FCC] = 0x12,
-		[BQ27XXX_REG_CYCT] = 0x2a,
-		[BQ27XXX_REG_AE] = 0x22,
-		[BQ27XXX_REG_SOC] = 0x2c,
-		[BQ27XXX_REG_DCAP] = 0x3c,
-		[BQ27XXX_REG_AP] = 0x24,
-		[BQ27XXX_DM_CTRL] = 0x61,
-		[BQ27XXX_DM_CLASS] = 0x3e,
-		[BQ27XXX_DM_BLOCK] = 0x3f,
-		[BQ27XXX_DM_DATA] = 0x40,
-		[BQ27XXX_DM_CKSUM] = 0x60,
-	},
 	[BQ27510G3] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -571,24 +499,6 @@ static enum power_supply_property bq2750x_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property bq2751x_battery_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
-	POWER_SUPPLY_PROP_TEMP,
-	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
-	POWER_SUPPLY_PROP_CHARGE_NOW,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_CYCLE_COUNT,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_MANUFACTURER,
-};
-
 static enum power_supply_property bq27500_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -610,48 +520,6 @@ static enum power_supply_property bq27500_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property bq27510g1_battery_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
-	POWER_SUPPLY_PROP_TEMP,
-	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
-	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
-	POWER_SUPPLY_PROP_CHARGE_NOW,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_CYCLE_COUNT,
-	POWER_SUPPLY_PROP_ENERGY_NOW,
-	POWER_SUPPLY_PROP_POWER_AVG,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_MANUFACTURER,
-};
-
-static enum power_supply_property bq27510g2_battery_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
-	POWER_SUPPLY_PROP_TEMP,
-	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
-	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
-	POWER_SUPPLY_PROP_CHARGE_NOW,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_CYCLE_COUNT,
-	POWER_SUPPLY_PROP_ENERGY_NOW,
-	POWER_SUPPLY_PROP_POWER_AVG,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_MANUFACTURER,
-};
-
 static enum power_supply_property bq27510g3_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -831,10 +699,7 @@ static struct {
 	BQ27XXX_PROP(BQ27000, bq27000_battery_props),
 	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
 	BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
-	BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
 	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
-	BQ27XXX_PROP(BQ27510G1, bq27510g1_battery_props),
-	BQ27XXX_PROP(BQ27510G2, bq27510g2_battery_props),
 	BQ27XXX_PROP(BQ27510G3, bq27510g3_battery_props),
 	BQ27XXX_PROP(BQ27520G1, bq27520g1_battery_props),
 	BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
@@ -1532,10 +1397,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 {
 	switch (di->chip) {
 	case BQ2750X:
-	case BQ2751X:
 	case BQ27500:
-	case BQ27510G1:
-	case BQ27510G2:
 	case BQ27510G3:
 	case BQ27520G1:
 	case BQ27520G2:
@@ -1905,9 +1767,6 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di, enum bq27xxx_chip real
 	case BQ27010:   BQ27XXX_INIT(real_chip, 0, 0); break;
 	case BQ2750X:   BQ27XXX_INIT(real_chip, 0, 0); break;
 	case BQ27500:   BQ27XXX_INIT(real_chip, bq27500_dm_regs, 0x04143672); break;
-	case BQ2751X:   BQ27XXX_INIT(real_chip, 0, 0); break;
-	case BQ27510G1: BQ27XXX_INIT(real_chip, 0, 0); break;
-	case BQ27510G2: BQ27XXX_INIT(real_chip, 0, 0); break;
 	case BQ27510G3: BQ27XXX_INIT(real_chip, 0, 0); break;
 	case BQ27520G1: BQ27XXX_INIT(real_chip, 0, 0); break;
 	case BQ27520G2: BQ27XXX_INIT(real_chip, 0, 0); break;
@@ -1919,7 +1778,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di, enum bq27xxx_chip real
 	case BQ27421:   BQ27XXX_INIT(real_chip, bq27421_dm_regs, 0x80008000); break;
 
 	                /* members of categories */
+	case BQ2751X:   BQ27XXX_INIT(BQ27510G3, 0, 0); break;
 	case BQ2752X:   BQ27XXX_INIT(BQ27510G3, 0, 0); break;
+	case BQ27510G1: BQ27XXX_INIT(BQ27500,   0, 0); break;
+	case BQ27510G2: BQ27XXX_INIT(BQ27500,   0, 0); break;
 	case BQ27531:   BQ27XXX_INIT(BQ27530,   0, 0); break;
 	case BQ27542:   BQ27XXX_INIT(BQ27541,   0, 0); break;
 	case BQ27546:   BQ27XXX_INIT(BQ27541,   0, 0); break;
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 4577727..485fbdf 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -6,11 +6,8 @@ enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
 	BQ2750X, /* bq27500 deprecated alias */
-	BQ2751X, /* bq27510, bq27520 deprecated alias */
-	BQ27500, /* bq27500/1 */
-	BQ27510G1, /* bq27510G1 */
-	BQ27510G2, /* bq27510G2 */
-	BQ27510G3, /* bq27510G3 */
+	BQ27500, /* bq27500/1, bq27510G1, bq27510G2 */
+	BQ27510G3, /* bq27510G3, bq27510, bq27520 */
 	BQ27520G1, /* bq27520G1 */
 	BQ27520G2, /* bq27520G2 */
 	BQ27520G3, /* bq27520G3 */
@@ -21,7 +18,10 @@ enum bq27xxx_chip {
 	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
 
 	/* members of categories; translate these to category in _setup() */
-	BQ2752X, /* deprecated alias */
+	BQ2751X, /* bq27510 deprecated alias */
+	BQ2752X, /* bq27520 deprecated alias */
+	BQ27510G1,
+	BQ27510G2,
 	BQ27531,
 	BQ27542,
 	BQ27546,
-- 
2.9.3
