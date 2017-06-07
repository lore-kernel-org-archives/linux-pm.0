From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 11/11] power: supply: bq27xxx: Remove duplicate register arrays
Date: Wed,  7 Jun 2017 11:37:59 -0700
Message-ID: <20170607183759.20261-12-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35959 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbdFGSim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so2404085pfd.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 11:38:42 -0700 (PDT)
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

BQ2751X & BQ27510G3 are identical.
BQ27500 & BQ27510G1 & BQ27510G2 are identical.
Make BQ2751X & BQ27510G1/2 aliases.
Remove the duplicate arrays, etc.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c     | 126 -----------------------------
 drivers/power/supply/bq27xxx_battery_i2c.c |   8 +-
 include/linux/power/bq27xxx_battery.h      |  12 +--
 3 files changed, 10 insertions(+), 136 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index f4449aba..b81f986d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -201,26 +201,6 @@ static u8 bq27xxx_regs[BQ27MAX][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 		BQ27XXX_DM_REG_ROWS,
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
-		BQ27XXX_DM_REG_ROWS,
-	},
 	[BQ27500] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -241,46 +221,6 @@ static u8 bq27xxx_regs[BQ27MAX][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_AP] = 0x24,
 		BQ27XXX_DM_REG_ROWS,
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
-		BQ27XXX_DM_REG_ROWS,
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
-		BQ27XXX_DM_REG_ROWS,
-	},
 	[BQ27510G3] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -523,24 +463,6 @@ static enum power_supply_property bq2750x_battery_props[] = {
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
@@ -562,48 +484,6 @@ static enum power_supply_property bq27500_battery_props[] = {
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
@@ -783,10 +663,7 @@ static struct {
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
@@ -1577,10 +1454,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
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
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index a3656508..0ef0fca3 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -231,11 +231,11 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27200",   (BQ27000   << 16) |  BQ27000   },
 	{ "bq27210",   (BQ27010   << 16) |  BQ27010   },
 	{ "bq27500",   (BQ2750X   << 16) |  BQ2750X   },
-	{ "bq27510",   (BQ2751X   << 16) |  BQ2751X   },
-	{ "bq27520",   (BQ2752X   << 16) |  BQ2751X   },
+	{ "bq27510",   (BQ2751X   << 16) |  BQ27510G3 },
+	{ "bq27520",   (BQ2752X   << 16) |  BQ27510G3 },
 	{ "bq27500-1", (BQ27500   << 16) |  BQ27500   },
-	{ "bq27510g1", (BQ27510G1 << 16) |  BQ27510G1 },
-	{ "bq27510g2", (BQ27510G2 << 16) |  BQ27510G2 },
+	{ "bq27510g1", (BQ27510G1 << 16) |  BQ27500   },
+	{ "bq27510g2", (BQ27510G2 << 16) |  BQ27500   },
 	{ "bq27510g3", (BQ27510G3 << 16) |  BQ27510G3 },
 	{ "bq27520g1", (BQ27520G1 << 16) |  BQ27520G1 },
 	{ "bq27520g2", (BQ27520G2 << 16) |  BQ27520G2 },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index bec13b7a..acbe52e6 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -8,11 +8,8 @@ enum bq27xxx_chip {
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
@@ -23,7 +20,10 @@ enum bq27xxx_chip {
 	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
 	BQ27MAX,
 
-	BQ2752X, /* deprecated alias */
+	BQ2751X, /* bq27510 deprecated alias */
+	BQ2752X, /* bq27520 deprecated alias */
+	BQ27510G1,
+	BQ27510G2,
 	BQ27531,
 	BQ27542,
 	BQ27546,
-- 
2.13.0
