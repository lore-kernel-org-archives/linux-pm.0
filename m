From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.3 8/10] power: bq27xxx_battery: Enable chip data memory update for certain chips
Date: Fri, 31 Mar 2017 03:25:31 -0700
Message-ID: <20170331102533.27528-5-liam@networkimprov.net>
References: <20170331102533.27528-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34705 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932618AbdCaKZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 06:25:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id o123so16299805pga.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 03:25:52 -0700 (PDT)
In-Reply-To: <20170331102533.27528-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Support data memory update of BQ27500, 545, 421, 425, 441, 621.

Create IDs for for previously unID'd chips, to index arrays for unseal keys
and data memory register tables.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c     | 73 +++++++++++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c | 16 +++----
 include/linux/power/bq27xxx_battery.h      | 11 +++++
 3 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 41eb5b7..3ff854e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -57,7 +57,7 @@
 
 #include <linux/power/bq27xxx_battery.h>
 
-#define DRIVER_VERSION		"1.2.0"
+#define DRIVER_VERSION		"1.3.0"
 
 #define BQ27XXX_MANUFACTURER	"Texas Instruments"
 
@@ -855,6 +855,54 @@ static const char* bq27xxx_dm_reg_name[] = {
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
 
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
@@ -1830,9 +1878,30 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+	di->unseal_key = bq27xxx_unseal_keys[di->chip];
+	di->dm_regs = bq27xxx_dm_regs[di->chip];
+
+	switch(di->chip) {  /* translate category members */
+	case BQ2752X:
+		di->chip = BQ27510G3; break;
+	case BQ27531:
+		di->chip = BQ27530;   break;
+	case BQ27542:
+	case BQ27546:
+	case BQ27742:
+		di->chip = BQ27541;   break;
+	case BQ27425:
+	case BQ27441:
+	case BQ27621:
+		di->chip = BQ27421;   break;
+	default:
+		break;
+	}
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
index 227eb08..7c9bf03 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,6 +2,7 @@
 #define __LINUX_BQ27X00_BATTERY_H__
 
 enum bq27xxx_chip {
+	/* category prototypes; index for bq27xxx_regs[] */
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
 	BQ2750X, /* bq27500 deprecated alias */
@@ -18,6 +19,16 @@ enum bq27xxx_chip {
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
 	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+
+	/* category members; translated to category prototype in _setup() */
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
