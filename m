From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 3/5] power: supply: bq27xxx: Enable data memory update for certain chips
Date: Wed, 23 Aug 2017 20:36:15 -0700
Message-ID: <20170824033617.20840-4-liam@networkimprov.net>
References: <20170824033617.20840-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36861 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdHXDg5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 23:36:57 -0400
Received: by mail-pg0-f66.google.com with SMTP id m7so1961362pga.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2017 20:36:56 -0700 (PDT)
In-Reply-To: <20170824033617.20840-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Support data memory update on BQ27425. Parameters from TI datasheets are also
provided for BQ27500, 545, 421, 441, 621; however these are commented out,
as they are not tested.

Add BQ27XXX_O_CFGUP & _O_RAM for use in bq27xxx_chip_data[n].opts
and by data memory update functions.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 175 ++++++++++++++++++++++++---------
 include/linux/power/bq27xxx_battery.h  |   1 -
 2 files changed, 126 insertions(+), 50 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index b186216d..f2e55b90 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -58,8 +58,6 @@
 
 #include <linux/power/bq27xxx_battery.h>
 
-#define DRIVER_VERSION		"1.2.0"
-
 #define BQ27XXX_MANUFACTURER	"Texas Instruments"
 
 /* BQ27XXX Flags */
@@ -785,46 +783,138 @@ static enum power_supply_property bq27421_props[] = {
 #define bq27441_props bq27421_props
 #define bq27621_props bq27421_props
 
+struct bq27xxx_dm_reg {
+	u8 subclass_id;
+	u8 offset;
+	u8 bytes;
+	u16 min, max;
+};
+
+enum bq27xxx_dm_reg_id {
+	BQ27XXX_DM_DESIGN_CAPACITY = 0,
+	BQ27XXX_DM_DESIGN_ENERGY,
+	BQ27XXX_DM_TERMINATE_VOLTAGE,
+};
+
+#define bq27000_dm_regs 0
+#define bq27010_dm_regs 0
+#define bq2750x_dm_regs 0
+#define bq2751x_dm_regs 0
+#define bq2752x_dm_regs 0
+
+#if 0 /* not yet tested */
+static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 10, 2,    0, 65535 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { }, /* missing on chip */
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
+};
+#else
+#define bq27500_dm_regs 0
+#endif
+
+/* todo create data memory definitions from datasheets and test on chips */
+#define bq27510g1_dm_regs 0
+#define bq27510g2_dm_regs 0
+#define bq27510g3_dm_regs 0
+#define bq27520g1_dm_regs 0
+#define bq27520g2_dm_regs 0
+#define bq27520g3_dm_regs 0
+#define bq27520g4_dm_regs 0
+#define bq27530_dm_regs 0
+#define bq27531_dm_regs 0
+#define bq27541_dm_regs 0
+#define bq27542_dm_regs 0
+#define bq27546_dm_regs 0
+#define bq27742_dm_regs 0
+
+#if 0 /* not yet tested */
+static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 23, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 48, 25, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 67, 2, 2800,  3700 },
+};
+#else
+#define bq27545_dm_regs 0
+#endif
+
+#if 0 /* not yet tested */
+static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
+};
+#else
+#define bq27421_dm_regs 0
+#endif
+
+static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
+};
+
+#if 0 /* not yet tested */
+#define bq27441_dm_regs bq27421_dm_regs
+#else
+#define bq27441_dm_regs 0
+#endif
+
+#if 0 /* not yet tested */
+static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
+};
+#else
+#define bq27621_dm_regs 0
+#endif
+
 #define BQ27XXX_O_ZERO	0x00000001
 #define BQ27XXX_O_OTDC	0x00000002
 #define BQ27XXX_O_UTOT  0x00000004
+#define BQ27XXX_O_CFGUP	0x00000008
+#define BQ27XXX_O_RAM	0x00000010
 
-#define BQ27XXX_DATA(ref, opt) {		\
+#define BQ27XXX_DATA(ref, key, opt) {		\
 	.opts = (opt),				\
+	.unseal_key = key,			\
 	.regs  = ref##_regs,			\
+	.dm_regs = ref##_dm_regs,		\
 	.props = ref##_props,			\
 	.props_size = ARRAY_SIZE(ref##_props) }
 
 static struct {
 	u32 opts;
+	u32 unseal_key;
 	u8 *regs;
+	struct bq27xxx_dm_reg *dm_regs;
 	enum power_supply_property *props;
 	size_t props_size;
 } bq27xxx_chip_data[] = {
-	[BQ27000]   = BQ27XXX_DATA(bq27000,   BQ27XXX_O_ZERO),
-	[BQ27010]   = BQ27XXX_DATA(bq27010,   BQ27XXX_O_ZERO),
-	[BQ2750X]   = BQ27XXX_DATA(bq2750x,   BQ27XXX_O_OTDC),
-	[BQ2751X]   = BQ27XXX_DATA(bq2751x,   BQ27XXX_O_OTDC),
-	[BQ2752X]   = BQ27XXX_DATA(bq2752x,   BQ27XXX_O_OTDC),
-	[BQ27500]   = BQ27XXX_DATA(bq27500,   BQ27XXX_O_OTDC),
-	[BQ27510G1] = BQ27XXX_DATA(bq27510g1, BQ27XXX_O_OTDC),
-	[BQ27510G2] = BQ27XXX_DATA(bq27510g2, BQ27XXX_O_OTDC),
-	[BQ27510G3] = BQ27XXX_DATA(bq27510g3, BQ27XXX_O_OTDC),
-	[BQ27520G1] = BQ27XXX_DATA(bq27520g1, BQ27XXX_O_OTDC),
-	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, BQ27XXX_O_OTDC),
-	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, BQ27XXX_O_OTDC),
-	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, BQ27XXX_O_OTDC),
-	[BQ27530]   = BQ27XXX_DATA(bq27530,   BQ27XXX_O_UTOT),
-	[BQ27531]   = BQ27XXX_DATA(bq27531,   BQ27XXX_O_UTOT),
-	[BQ27541]   = BQ27XXX_DATA(bq27541,   BQ27XXX_O_OTDC),
-	[BQ27542]   = BQ27XXX_DATA(bq27542,   BQ27XXX_O_OTDC),
-	[BQ27546]   = BQ27XXX_DATA(bq27546,   BQ27XXX_O_OTDC),
-	[BQ27742]   = BQ27XXX_DATA(bq27742,   BQ27XXX_O_OTDC),
-	[BQ27545]   = BQ27XXX_DATA(bq27545,   BQ27XXX_O_OTDC),
-	[BQ27421]   = BQ27XXX_DATA(bq27421,   BQ27XXX_O_UTOT),
-	[BQ27425]   = BQ27XXX_DATA(bq27425,   BQ27XXX_O_UTOT),
-	[BQ27441]   = BQ27XXX_DATA(bq27441,   BQ27XXX_O_UTOT),
-	[BQ27621]   = BQ27XXX_DATA(bq27621,   BQ27XXX_O_UTOT),
+	[BQ27000]   = BQ27XXX_DATA(bq27000,   0         , BQ27XXX_O_ZERO),
+	[BQ27010]   = BQ27XXX_DATA(bq27010,   0         , BQ27XXX_O_ZERO),
+	[BQ2750X]   = BQ27XXX_DATA(bq2750x,   0         , BQ27XXX_O_OTDC),
+	[BQ2751X]   = BQ27XXX_DATA(bq2751x,   0         , BQ27XXX_O_OTDC),
+	[BQ2752X]   = BQ27XXX_DATA(bq2752x,   0         , BQ27XXX_O_OTDC),
+	[BQ27500]   = BQ27XXX_DATA(bq27500,   0x04143672, BQ27XXX_O_OTDC),
+	[BQ27510G1] = BQ27XXX_DATA(bq27510g1, 0         , BQ27XXX_O_OTDC),
+	[BQ27510G2] = BQ27XXX_DATA(bq27510g2, 0         , BQ27XXX_O_OTDC),
+	[BQ27510G3] = BQ27XXX_DATA(bq27510g3, 0         , BQ27XXX_O_OTDC),
+	[BQ27520G1] = BQ27XXX_DATA(bq27520g1, 0         , BQ27XXX_O_OTDC),
+	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, 0         , BQ27XXX_O_OTDC),
+	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, 0         , BQ27XXX_O_OTDC),
+	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, 0         , BQ27XXX_O_OTDC),
+	[BQ27530]   = BQ27XXX_DATA(bq27530,   0         , BQ27XXX_O_UTOT),
+	[BQ27531]   = BQ27XXX_DATA(bq27531,   0         , BQ27XXX_O_UTOT),
+	[BQ27541]   = BQ27XXX_DATA(bq27541,   0         , BQ27XXX_O_OTDC),
+	[BQ27542]   = BQ27XXX_DATA(bq27542,   0         , BQ27XXX_O_OTDC),
+	[BQ27546]   = BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
+	[BQ27742]   = BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
+	[BQ27545]   = BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
+	[BQ27421]   = BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
+	[BQ27425]   = BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
+	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
+	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -834,13 +924,6 @@ static LIST_HEAD(bq27xxx_battery_devices);
 
 #define BQ27XXX_DM_SZ	32
 
-struct bq27xxx_dm_reg {
-	u8 subclass_id;
-	u8 offset;
-	u8 bytes;
-	u16 min, max;
-};
-
 /**
  * struct bq27xxx_dm_buf - chip data memory buffer
  * @class: data memory subclass_id
@@ -873,12 +956,6 @@ static inline u16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
 	return NULL;
 }
 
-enum bq27xxx_dm_reg_id {
-	BQ27XXX_DM_DESIGN_CAPACITY = 0,
-	BQ27XXX_DM_DESIGN_ENERGY,
-	BQ27XXX_DM_TERMINATE_VOLTAGE,
-};
-
 static const char * const bq27xxx_dm_reg_name[] = {
 	[BQ27XXX_DM_DESIGN_CAPACITY] = "design-capacity",
 	[BQ27XXX_DM_DESIGN_ENERGY] = "design-energy",
@@ -1121,9 +1198,9 @@ static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
 	}
 
 #ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
-	if (!di->ram_chip && !bq27xxx_dt_to_nvm) {
+	if (!(di->opts & BQ27XXX_O_RAM) && !bq27xxx_dt_to_nvm) {
 #else
-	if (!di->ram_chip) {
+	if (!(di->opts & BQ27XXX_O_RAM)) {
 #endif
 		/* devicetree and NVM differ; defer to NVM */
 		dev_warn(di->dev, "%s has %u; update to %u disallowed "
@@ -1159,7 +1236,7 @@ static int bq27xxx_battery_cfgupdate_priv(struct bq27xxx_device_info *di, bool a
 			return ret;
 	} while (!!(ret & BQ27XXX_FLAG_CFGUP) != active && --try);
 
-	if (!try) {
+	if (!try && di->chip != BQ27425) { // 425 has a bug
 		dev_err(di->dev, "timed out waiting for cfgupdate flag %d\n", active);
 		return -EINVAL;
 	}
@@ -1191,7 +1268,7 @@ static inline int bq27xxx_battery_soft_reset(struct bq27xxx_device_info *di)
 static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
 					  struct bq27xxx_dm_buf *buf)
 {
-	bool cfgup = di->chip == BQ27421; /* assume related chips need cfgupdate */
+	bool cfgup = di->opts & BQ27XXX_O_CFGUP;
 	int ret;
 
 	if (!buf->dirty)
@@ -1290,7 +1367,7 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
 
 	bq27xxx_battery_seal(di);
 
-	if (updated && di->chip != BQ27421) { /* not a cfgupdate chip, so reset */
+	if (updated && !(di->opts & BQ27XXX_O_CFGUP)) {
 		bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
 		BQ27XXX_MSLEEP(300); /* reset time is not documented */
 	}
@@ -1900,8 +1977,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
 
-	di->regs = bq27xxx_chip_data[di->chip].regs;
-	di->opts = bq27xxx_chip_data[di->chip].opts;
+	di->regs       = bq27xxx_chip_data[di->chip].regs;
+	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
+	di->dm_regs    = bq27xxx_chip_data[di->chip].dm_regs;
+	di->opts       = bq27xxx_chip_data[di->chip].opts;
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
@@ -1920,8 +1999,6 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		return PTR_ERR(di->bat);
 	}
 
-	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
-
 	bq27xxx_battery_settings(di);
 	bq27xxx_battery_update(di);
 
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 77fe94f1..8a8a3f61 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -71,7 +71,6 @@ struct bq27xxx_device_info {
 	struct device *dev;
 	int id;
 	enum bq27xxx_chip chip;
-	bool ram_chip;
 	u32 opts;
 	const char *name;
 	struct bq27xxx_dm_reg *dm_regs;
-- 
2.13.2
