From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.6 07/11] power: bq27xxx_battery: Enable data memory update for certain chips
Date: Sun,  9 Apr 2017 22:07:08 -0700
Message-ID: <20170410050712.930-4-liam@networkimprov.net>
References: <20170410050712.930-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33278 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdDJFHp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 01:07:45 -0400
Received: by mail-pg0-f66.google.com with SMTP id 79so24302281pgf.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Apr 2017 22:07:45 -0700 (PDT)
In-Reply-To: <20170410050712.930-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Support data memory update on BQ27500, 545, 425, 421, 441, 621.

Create IDs for for previously unID'd chips, to index arrays for unseal keys
and data memory register tables.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c     | 88 ++++++++++++++++++++++++++++--
 drivers/power/supply/bq27xxx_battery_i2c.c | 16 +++---
 include/linux/power/bq27xxx_battery.h      | 13 +++++
 3 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index f7e4be7..cebaf59 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -58,7 +58,7 @@
 
 #include <linux/power/bq27xxx_battery.h>
 
-#define DRIVER_VERSION		"1.2.0"
+#define DRIVER_VERSION		"1.3.0"
 
 #define BQ27XXX_MANUFACTURER	"Texas Instruments"
 
@@ -132,7 +132,7 @@ enum bq27xxx_reg_index {
 	[BQ27XXX_DM_CKSUM] = 0x60
 
 /* Register mappings */
-static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
+static u8 bq27xxx_regs[BQ27MAX][BQ27XXX_REG_MAX] = {
 	[BQ27000] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -779,7 +779,7 @@ static enum power_supply_property bq27421_battery_props[] = {
 static struct {
 	enum power_supply_property *props;
 	size_t size;
-} bq27xxx_battery_props[] = {
+} bq27xxx_battery_props[BQ27MAX] = {
 	BQ27XXX_PROP(BQ27000, bq27000_battery_props),
 	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
 	BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
@@ -798,6 +798,33 @@ static struct {
 	BQ27XXX_PROP(BQ27421, bq27421_battery_props),
 };
 
+static enum bq27xxx_chip bq27xxx_chips[] = {
+	[BQ27000]   = BQ27000,
+	[BQ27010]   = BQ27010,
+	[BQ2750X]   = BQ2750X,
+	[BQ2751X]   = BQ2751X,
+	[BQ2752X]   = BQ2751X,
+	[BQ27500]   = BQ27500,
+	[BQ27510G1] = BQ27510G1,
+	[BQ27510G2] = BQ27510G2,
+	[BQ27510G3] = BQ27510G3,
+	[BQ27520G1] = BQ27520G1,
+	[BQ27520G2] = BQ27520G2,
+	[BQ27520G3] = BQ27520G3,
+	[BQ27520G4] = BQ27520G4,
+	[BQ27530]   = BQ27530,
+	[BQ27531]   = BQ27530,
+	[BQ27541]   = BQ27541,
+	[BQ27542]   = BQ27541,
+	[BQ27546]   = BQ27541,
+	[BQ27742]   = BQ27541,
+	[BQ27545]   = BQ27545,
+	[BQ27421]   = BQ27421,
+	[BQ27425]   = BQ27421,
+	[BQ27441]   = BQ27421,
+	[BQ27621]   = BQ27421,
+};
+
 static DEFINE_MUTEX(bq27xxx_list_lock);
 static LIST_HEAD(bq27xxx_battery_devices);
 
@@ -856,6 +883,54 @@ static const char* bq27xxx_dm_reg_name[] = {
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
 };
 
+static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 10, 2,    0, 65535 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { }, /* missing on chip */
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
+};
+
+static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 23, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 48, 25, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 67, 2, 2800,  3700 },
+};
+
+static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
+};
+
+static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
+};
+
+static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
+};
+
+static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
+	[BQ27500] = bq27500_dm_regs,
+	[BQ27545] = bq27545_dm_regs,
+	[BQ27421] = bq27421_dm_regs,
+	[BQ27425] = bq27425_dm_regs,
+	[BQ27441] = bq27421_dm_regs,
+	[BQ27621] = bq27621_dm_regs,
+};
+
+static u32 bq27xxx_unseal_keys[] = {
+	[BQ27500] = 0x04143672,
+	[BQ27545] = 0x04143672,
+	[BQ27421] = 0x80008000,
+	[BQ27425] = 0x04143672,
+	[BQ27441] = 0x80008000,
+	[BQ27621] = 0x80008000,
+};
+
 
 static bool bq27xxx_dt_battery = true;
 module_param_named(use_monitored_battery, bq27xxx_dt_battery, bool, S_IRUGO);
@@ -1852,9 +1927,14 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+	di->unseal_key = bq27xxx_unseal_keys[di->chip];
+	di->dm_regs = bq27xxx_dm_regs[di->chip];
+	di->chip = bq27xxx_chips[di->chip];
+
+	di->regs = bq27xxx_regs[di->chip];
+
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
-	di->regs = bq27xxx_regs[di->chip];
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index a597221..0b11ed4 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -230,7 +230,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27210", BQ27010 },
 	{ "bq27500", BQ2750X },
 	{ "bq27510", BQ2751X },
-	{ "bq27520", BQ2751X },
+	{ "bq27520", BQ2752X },
 	{ "bq27500-1", BQ27500 },
 	{ "bq27510g1", BQ27510G1 },
 	{ "bq27510g2", BQ27510G2 },
@@ -240,16 +240,16 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27520g3", BQ27520G3 },
 	{ "bq27520g4", BQ27520G4 },
 	{ "bq27530", BQ27530 },
-	{ "bq27531", BQ27530 },
+	{ "bq27531", BQ27531 },
 	{ "bq27541", BQ27541 },
-	{ "bq27542", BQ27541 },
-	{ "bq27546", BQ27541 },
-	{ "bq27742", BQ27541 },
+	{ "bq27542", BQ27542 },
+	{ "bq27546", BQ27546 },
+	{ "bq27742", BQ27742 },
 	{ "bq27545", BQ27545 },
 	{ "bq27421", BQ27421 },
-	{ "bq27425", BQ27421 },
-	{ "bq27441", BQ27421 },
-	{ "bq27621", BQ27421 },
+	{ "bq27425", BQ27425 },
+	{ "bq27441", BQ27441 },
+	{ "bq27621", BQ27621 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 227eb08..09e1656 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,6 +2,8 @@
 #define __LINUX_BQ27X00_BATTERY_H__
 
 enum bq27xxx_chip {
+	/* these index bq27xxx_regs[] & bq27xxx_battery_props[] */
+	/* and map to themselves in bq27xxx_chips[]             */
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
 	BQ2750X, /* bq27500 deprecated alias */
@@ -18,6 +20,17 @@ enum bq27xxx_chip {
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
 	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+	BQ27MAX,
+
+	/* these map to above in bq27xxx_chips[] */
+	BQ2752X, /* deprecated alias */
+	BQ27531,
+	BQ27542,
+	BQ27546,
+	BQ27742,
+	BQ27425,
+	BQ27441,
+	BQ27621,
 };
 
 /**
-- 
2.9.3
