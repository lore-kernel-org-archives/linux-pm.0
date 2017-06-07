From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 09/11] power: supply: bq27xxx: Enable data memory update for certain chips
Date: Wed,  7 Jun 2017 11:37:57 -0700
Message-ID: <20170607183759.20261-10-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35845 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdFGSiz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id v18so2155176pgb.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 11:38:44 -0700 (PDT)
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Support data memory update on BQ27500, 545, 425, 421, 441, 621.
With exception of BQ27425, these are only enabled #ifdef DEBUG,
as they are not tested.

Create IDs for for previously unID'd chips, to index arrays for unseal keys
and data memory register tables.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c     | 75 ++++++++++++++++++++++++++++--
 drivers/power/supply/bq27xxx_battery_i2c.c | 52 +++++++++++----------
 include/linux/power/bq27xxx_battery.h      | 14 ++++++
 3 files changed, 111 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index ed44439d..a7014525 100644
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
@@ -856,6 +856,63 @@ static const char * const bq27xxx_dm_reg_name[] = {
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
 };
 
+static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
+};
+
+#ifdef DEBUG
+/* these have not been tested */
+
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
+static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
+};
+
+#endif
+
+static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
+	[BQ27425] = bq27425_dm_regs,
+#ifdef DEBUG
+	[BQ27500] = bq27500_dm_regs,
+	[BQ27545] = bq27545_dm_regs,
+	[BQ27421] = bq27421_dm_regs,
+	[BQ27441] = bq27421_dm_regs,
+	[BQ27621] = bq27621_dm_regs,
+#else
+	[BQ27621] = 0 /* must have highest ID */
+#endif
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
 
 static bool bq27xxx_dt_to_nvm = true;
 module_param_named(dt_monitored_battery_updates_nvm, bq27xxx_dt_to_nvm, bool, 0444);
@@ -1882,9 +1939,17 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+	di->ram_chip = di->real_chip == BQ27421 ||
+		       di->real_chip == BQ27441 ||
+		       di->real_chip == BQ27621;
+
+	di->unseal_key = bq27xxx_unseal_keys[di->real_chip];
+	di->dm_regs = bq27xxx_dm_regs[di->real_chip];
+
+	di->regs = bq27xxx_regs[di->chip];
+
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
-	di->regs = bq27xxx_regs[di->chip];
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
@@ -1999,7 +2064,7 @@ static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, di);
 
 	di->dev = &pdev->dev;
-	di->chip = pdata->chip;
+	di->chip = di->real_chip = pdata->chip;
 	di->name = pdata->name ?: dev_name(&pdev->dev);
 	di->bus.read = bq27xxx_battery_platform_read;
 
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index a5972214..a3656508 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -169,7 +169,8 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 
 	di->id = num;
 	di->dev = &client->dev;
-	di->chip = id->driver_data;
+	di->real_chip = id->driver_data >> 16;
+	di->chip = (u16) id->driver_data;
 	di->name = name;
 
 	di->bus.read = bq27xxx_battery_i2c_read;
@@ -226,30 +227,31 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
-	{ "bq27200", BQ27000 },
-	{ "bq27210", BQ27010 },
-	{ "bq27500", BQ2750X },
-	{ "bq27510", BQ2751X },
-	{ "bq27520", BQ2751X },
-	{ "bq27500-1", BQ27500 },
-	{ "bq27510g1", BQ27510G1 },
-	{ "bq27510g2", BQ27510G2 },
-	{ "bq27510g3", BQ27510G3 },
-	{ "bq27520g1", BQ27520G1 },
-	{ "bq27520g2", BQ27520G2 },
-	{ "bq27520g3", BQ27520G3 },
-	{ "bq27520g4", BQ27520G4 },
-	{ "bq27530", BQ27530 },
-	{ "bq27531", BQ27530 },
-	{ "bq27541", BQ27541 },
-	{ "bq27542", BQ27541 },
-	{ "bq27546", BQ27541 },
-	{ "bq27742", BQ27541 },
-	{ "bq27545", BQ27545 },
-	{ "bq27421", BQ27421 },
-	{ "bq27425", BQ27421 },
-	{ "bq27441", BQ27421 },
-	{ "bq27621", BQ27421 },
+	/* dest.    di->real_chip       di->chip      */
+	{ "bq27200",   (BQ27000   << 16) |  BQ27000   },
+	{ "bq27210",   (BQ27010   << 16) |  BQ27010   },
+	{ "bq27500",   (BQ2750X   << 16) |  BQ2750X   },
+	{ "bq27510",   (BQ2751X   << 16) |  BQ2751X   },
+	{ "bq27520",   (BQ2752X   << 16) |  BQ2751X   },
+	{ "bq27500-1", (BQ27500   << 16) |  BQ27500   },
+	{ "bq27510g1", (BQ27510G1 << 16) |  BQ27510G1 },
+	{ "bq27510g2", (BQ27510G2 << 16) |  BQ27510G2 },
+	{ "bq27510g3", (BQ27510G3 << 16) |  BQ27510G3 },
+	{ "bq27520g1", (BQ27520G1 << 16) |  BQ27520G1 },
+	{ "bq27520g2", (BQ27520G2 << 16) |  BQ27520G2 },
+	{ "bq27520g3", (BQ27520G3 << 16) |  BQ27520G3 },
+	{ "bq27520g4", (BQ27520G4 << 16) |  BQ27520G4 },
+	{ "bq27530",   (BQ27530   << 16) |  BQ27530   },
+	{ "bq27531",   (BQ27531   << 16) |  BQ27530   },
+	{ "bq27541",   (BQ27541   << 16) |  BQ27541   },
+	{ "bq27542",   (BQ27542   << 16) |  BQ27541   },
+	{ "bq27546",   (BQ27546   << 16) |  BQ27541   },
+	{ "bq27742",   (BQ27742   << 16) |  BQ27541   },
+	{ "bq27545",   (BQ27545   << 16) |  BQ27545   },
+	{ "bq27421",   (BQ27421   << 16) |  BQ27421   },
+	{ "bq27425",   (BQ27425   << 16) |  BQ27421   },
+	{ "bq27441",   (BQ27441   << 16) |  BQ27421   },
+	{ "bq27621",   (BQ27621   << 16) |  BQ27421   },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 11e11685..bec13b7a 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,6 +2,9 @@
 #define __LINUX_BQ27X00_BATTERY_H__
 
 enum bq27xxx_chip {
+	/* all index bq27xxx_unseal_keys[] & bq27xxx_dm_regs[] */
+
+	/* these index bq27xxx_regs[] & bq27xxx_battery_props[] */
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
 	BQ2750X, /* bq27500 deprecated alias */
@@ -18,6 +21,16 @@ enum bq27xxx_chip {
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
 	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+	BQ27MAX,
+
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
@@ -62,6 +75,7 @@ struct bq27xxx_reg_cache {
 struct bq27xxx_device_info {
 	struct device *dev;
 	int id;
+	enum bq27xxx_chip real_chip;
 	enum bq27xxx_chip chip;
 	bool ram_chip;
 	const char *name;
-- 
2.13.0
