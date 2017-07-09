From: Liam Breck <liam@networkimprov.net>
Subject: [RFC v1 2/6] power: supply: bq27xxx: Add chip IDs for previously shadowed chips
Date: Sat,  8 Jul 2017 19:16:56 -0700
Message-ID: <20170709021700.14354-3-liam@networkimprov.net>
References: <20170709021700.14354-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33330 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdGICRj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jul 2017 22:17:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so8550148pgb.0
        for <linux-pm@vger.kernel.org>; Sat, 08 Jul 2017 19:17:39 -0700 (PDT)
In-Reply-To: <20170709021700.14354-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

For the existing feature set, these chips act like ones already listed,
so they had been given false but functional IDs. We will be adding features
which obsolete that shadowing, so the following IDs are added:
BQ2752X, 531, 542, 546, 742, 425, 441, 621

So as not to disturb code that relies on the shadowing,
bq27xxx_chip_data[n].acts_like now gives the previous ID for the above
chips. That field will no longer be necessary when the code in question can
test for specific options (to be provided in later patches) with:
(BQ27XXX_O_XYZ & di->opts)

No functional changes to the driver.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c     | 67 ++++++++++++++++++++++--------
 drivers/power/supply/bq27xxx_battery_i2c.c | 16 +++----
 include/linux/power/bq27xxx_battery.h      |  9 ++++
 3 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index f1c59613..8eafbe2b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -221,6 +221,7 @@ static u8
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 		BQ27XXX_DM_REG_ROWS,
 	},
+#define bq2752x_regs bq2751x_regs
 	bq27500_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -401,6 +402,7 @@ static u8
 		[BQ27XXX_REG_AP] = 0x24,
 		BQ27XXX_DM_REG_ROWS,
 	},
+#define bq27531_regs bq27530_regs
 	bq27541_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -421,6 +423,9 @@ static u8
 		[BQ27XXX_REG_AP] = 0x24,
 		BQ27XXX_DM_REG_ROWS,
 	},
+#define bq27542_regs bq27541_regs
+#define bq27546_regs bq27541_regs
+#define bq27742_regs bq27541_regs
 	bq27545_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -461,6 +466,9 @@ static u8
 		[BQ27XXX_REG_AP] = 0x18,
 		BQ27XXX_DM_REG_ROWS,
 	};
+#define bq27425_regs bq27421_regs
+#define bq27441_regs bq27421_regs
+#define bq27621_regs bq27421_regs
 
 static enum power_supply_property bq27000_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -539,6 +547,7 @@ static enum power_supply_property bq2751x_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq2752x_props bq2751x_props
 
 static enum power_supply_property bq27500_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -716,6 +725,7 @@ static enum power_supply_property bq27530_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq27531_props bq27530_props
 
 static enum power_supply_property bq27541_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -735,6 +745,9 @@ static enum power_supply_property bq27541_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq27542_props bq27541_props
+#define bq27546_props bq27541_props
+#define bq27742_props bq27541_props
 
 static enum power_supply_property bq27545_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -768,33 +781,48 @@ static enum power_supply_property bq27421_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq27425_props bq27421_props
+#define bq27441_props bq27421_props
+#define bq27621_props bq27421_props
 
-#define BQ27XXX_DATA(ref) {			\
+#define BQ27XXX_DATA(ref, act, opt) {		\
+	.opts = (opt),				\
+	.acts_like = act,			\
 	.regs  = bq27##ref##_regs,		\
 	.props = bq27##ref##_props,		\
 	.props_size = ARRAY_SIZE(bq27##ref##_props) }
 
 static struct {
+	u32 opts;
+	int acts_like; //todo drop this when opts fully implemented
 	u8 *regs;
 	enum power_supply_property *props;
 	size_t props_size;
 } bq27xxx_chip_data[] = {
-	[BQ27000]   = BQ27XXX_DATA(000),
-	[BQ27010]   = BQ27XXX_DATA(010),
-	[BQ2750X]   = BQ27XXX_DATA(50x),
-	[BQ2751X]   = BQ27XXX_DATA(51x),
-	[BQ27500]   = BQ27XXX_DATA(500),
-	[BQ27510G1] = BQ27XXX_DATA(510g1),
-	[BQ27510G2] = BQ27XXX_DATA(510g2),
-	[BQ27510G3] = BQ27XXX_DATA(510g3),
-	[BQ27520G1] = BQ27XXX_DATA(520g1),
-	[BQ27520G2] = BQ27XXX_DATA(520g2),
-	[BQ27520G3] = BQ27XXX_DATA(520g3),
-	[BQ27520G4] = BQ27XXX_DATA(520g4),
-	[BQ27530]   = BQ27XXX_DATA(530),
-	[BQ27541]   = BQ27XXX_DATA(541),
-	[BQ27545]   = BQ27XXX_DATA(545),
-	[BQ27421]   = BQ27XXX_DATA(421),
+	[BQ27000]   = BQ27XXX_DATA(000,   0, 0),
+	[BQ27010]   = BQ27XXX_DATA(010,   0, 0),
+	[BQ2750X]   = BQ27XXX_DATA(50x,   0, 0),
+	[BQ2751X]   = BQ27XXX_DATA(51x,   0, 0),
+	[BQ2752X]   = BQ27XXX_DATA(52x,   BQ2751X, 0),
+	[BQ27500]   = BQ27XXX_DATA(500,   0, 0),
+	[BQ27510G1] = BQ27XXX_DATA(510g1, 0, 0),
+	[BQ27510G2] = BQ27XXX_DATA(510g2, 0, 0),
+	[BQ27510G3] = BQ27XXX_DATA(510g3, 0, 0),
+	[BQ27520G1] = BQ27XXX_DATA(520g1, 0, 0),
+	[BQ27520G2] = BQ27XXX_DATA(520g2, 0, 0),
+	[BQ27520G3] = BQ27XXX_DATA(520g3, 0, 0),
+	[BQ27520G4] = BQ27XXX_DATA(520g4, 0, 0),
+	[BQ27530]   = BQ27XXX_DATA(530,   0, 0),
+	[BQ27531]   = BQ27XXX_DATA(531,   BQ27530, 0),
+	[BQ27541]   = BQ27XXX_DATA(541,   0, 0),
+	[BQ27542]   = BQ27XXX_DATA(542,   BQ27541, 0),
+	[BQ27546]   = BQ27XXX_DATA(546,   BQ27541, 0),
+	[BQ27742]   = BQ27XXX_DATA(742,   BQ27541, 0),
+	[BQ27545]   = BQ27XXX_DATA(545,   0, 0),
+	[BQ27421]   = BQ27XXX_DATA(421,   0, 0),
+	[BQ27425]   = BQ27XXX_DATA(425,   BQ27421, 0),
+	[BQ27441]   = BQ27XXX_DATA(441,   BQ27421, 0),
+	[BQ27621]   = BQ27XXX_DATA(621,   BQ27421, 0),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -1883,7 +1911,9 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
+
 	di->regs = bq27xxx_chip_data[di->chip].regs;
+	di->opts = bq27xxx_chip_data[di->chip].opts;
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
@@ -1896,6 +1926,9 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->get_property = bq27xxx_battery_get_property;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
+	if (bq27xxx_chip_data[di->chip].acts_like)
+		di->chip = bq27xxx_chip_data[di->chip].acts_like;
+
 	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat)) {
 		dev_err(di->dev, "failed to register battery\n");
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index a5972214..0b11ed47 100644
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
index 11e11685..77fe94f1 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -6,6 +6,7 @@ enum bq27xxx_chip {
 	BQ27010, /* bq27010, bq27210 */
 	BQ2750X, /* bq27500 deprecated alias */
 	BQ2751X, /* bq27510, bq27520 deprecated alias */
+	BQ2752X,
 	BQ27500, /* bq27500/1 */
 	BQ27510G1, /* bq27510G1 */
 	BQ27510G2, /* bq27510G2 */
@@ -15,9 +16,16 @@ enum bq27xxx_chip {
 	BQ27520G3, /* bq27520G3 */
 	BQ27520G4, /* bq27520G4 */
 	BQ27530, /* bq27530, bq27531 */
+	BQ27531,
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
+	BQ27542,
+	BQ27546,
+	BQ27742,
 	BQ27545, /* bq27545 */
 	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+	BQ27425,
+	BQ27441,
+	BQ27621,
 };
 
 /**
@@ -64,6 +72,7 @@ struct bq27xxx_device_info {
 	int id;
 	enum bq27xxx_chip chip;
 	bool ram_chip;
+	u32 opts;
 	const char *name;
 	struct bq27xxx_dm_reg *dm_regs;
 	u32 unseal_key;
-- 
2.13.1
