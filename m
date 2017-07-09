From: Liam Breck <liam@networkimprov.net>
Subject: [RFC v1 6/6] power: supply: bq27xxx: Remove duplicate chip data arrays
Date: Sat,  8 Jul 2017 19:17:00 -0700
Message-ID: <20170709021700.14354-7-liam@networkimprov.net>
References: <20170709021700.14354-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36283 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdGICRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jul 2017 22:17:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so9736898pfk.3
        for <linux-pm@vger.kernel.org>; Sat, 08 Jul 2017 19:17:43 -0700 (PDT)
In-Reply-To: <20170709021700.14354-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

BQ2751X & BQ27510G3 have identical regs & props.
BQ27500 & BQ27510G1 & BQ27510G2 have identical regs & props.
Remove the duplicate arrays.

No functional changes to the driver.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 129 ++-------------------------------
 1 file changed, 8 insertions(+), 121 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 54755c88..3632784e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -201,27 +201,8 @@ static u8
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 		BQ27XXX_DM_REG_ROWS,
 	},
-	bq2751x_regs[BQ27XXX_REG_MAX] = {
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
-#define bq2752x_regs bq2751x_regs
+#define bq2751x_regs bq27510g3_regs
+#define bq2752x_regs bq27510g3_regs
 	bq27500_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -242,46 +223,8 @@ static u8
 		[BQ27XXX_REG_AP] = 0x24,
 		BQ27XXX_DM_REG_ROWS,
 	},
-	bq27510g1_regs[BQ27XXX_REG_MAX] = {
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
-	bq27510g2_regs[BQ27XXX_REG_MAX] = {
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
+#define bq27510g1_regs bq27500_regs
+#define bq27510g2_regs bq27500_regs
 	bq27510g3_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -530,24 +473,8 @@ static enum power_supply_property bq2750x_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property bq2751x_props[] = {
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
-#define bq2752x_props bq2751x_props
+#define bq2751x_props bq27510g3_props
+#define bq2752x_props bq27510g3_props
 
 static enum power_supply_property bq27500_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -569,48 +496,8 @@ static enum power_supply_property bq27500_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
-
-static enum power_supply_property bq27510g1_props[] = {
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
-static enum power_supply_property bq27510g2_props[] = {
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
+#define bq27510g1_props bq27500_props
+#define bq27510g2_props bq27500_props
 
 static enum power_supply_property bq27510g3_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
-- 
2.13.1
