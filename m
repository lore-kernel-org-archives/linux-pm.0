From: Liam Breck <liam@networkimprov.net>
Subject: [RFC v1 3/6] power: supply: bq27xxx: Enable data memory update for certain chips
Date: Sat,  8 Jul 2017 19:16:57 -0700
Message-ID: <20170709021700.14354-4-liam@networkimprov.net>
References: <20170709021700.14354-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36259 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdGICRq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jul 2017 22:17:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so9736773pfk.3
        for <linux-pm@vger.kernel.org>; Sat, 08 Jul 2017 19:17:45 -0700 (PDT)
In-Reply-To: <20170709021700.14354-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Support data memory update on BQ27500, 545, 425, 421, 441, 621.
With exception of BQ27425, these are only enabled #ifdef DEBUG,
as they are not tested.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 164 ++++++++++++++++++++++++---------
 1 file changed, 123 insertions(+), 41 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 8eafbe2b..0bd46fae 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -58,7 +58,7 @@
 
 #include <linux/power/bq27xxx_battery.h>
 
-#define DRIVER_VERSION		"1.2.0"
+#define DRIVER_VERSION		"1.3.0"
 
 #define BQ27XXX_MANUFACTURER	"Texas Instruments"
 
@@ -785,44 +785,134 @@ static enum power_supply_property bq27421_props[] = {
 #define bq27441_props bq27421_props
 #define bq27621_props bq27421_props
 
-#define BQ27XXX_DATA(ref, act, opt) {		\
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
+#ifdef DEBUG //todo test data memory features on this chip
+static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 10, 2,    0, 65535 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { }, /* missing on chip */
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
+};
+#else
+#define bq27500_dm_regs 0
+#endif
+
+//todo create data memory definitions from datasheets and test on chips
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
+#ifdef DEBUG //todo test data memory features on this chip
+static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 23, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 48, 25, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 67, 2, 2800,  3700 },
+};
+#else
+#define bq27545_dm_regs 0
+#endif
+
+#ifdef DEBUG //todo test data memory features on this chip
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
+#ifdef DEBUG //todo test data memory features on this chip
+#define bq27441_dm_regs bq27421_dm_regs
+#else
+#define bq27441_dm_regs 0
+#endif
+
+#ifdef DEBUG //todo test data memory features on this chip
+static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
+};
+#else
+#define bq27621_dm_regs 0
+#endif
+
+#define BQ27XXX_DATA(ref, act, key, opt) {	\
 	.opts = (opt),				\
 	.acts_like = act,			\
+	.unseal_key = key,			\
 	.regs  = bq27##ref##_regs,		\
+	.dm_regs = bq27##ref##_dm_regs,		\
 	.props = bq27##ref##_props,		\
 	.props_size = ARRAY_SIZE(bq27##ref##_props) }
 
 static struct {
 	u32 opts;
 	int acts_like; //todo drop this when opts fully implemented
+	u32 unseal_key;
 	u8 *regs;
+	struct bq27xxx_dm_reg *dm_regs;
 	enum power_supply_property *props;
 	size_t props_size;
 } bq27xxx_chip_data[] = {
-	[BQ27000]   = BQ27XXX_DATA(000,   0, 0),
-	[BQ27010]   = BQ27XXX_DATA(010,   0, 0),
-	[BQ2750X]   = BQ27XXX_DATA(50x,   0, 0),
-	[BQ2751X]   = BQ27XXX_DATA(51x,   0, 0),
-	[BQ2752X]   = BQ27XXX_DATA(52x,   BQ2751X, 0),
-	[BQ27500]   = BQ27XXX_DATA(500,   0, 0),
-	[BQ27510G1] = BQ27XXX_DATA(510g1, 0, 0),
-	[BQ27510G2] = BQ27XXX_DATA(510g2, 0, 0),
-	[BQ27510G3] = BQ27XXX_DATA(510g3, 0, 0),
-	[BQ27520G1] = BQ27XXX_DATA(520g1, 0, 0),
-	[BQ27520G2] = BQ27XXX_DATA(520g2, 0, 0),
-	[BQ27520G3] = BQ27XXX_DATA(520g3, 0, 0),
-	[BQ27520G4] = BQ27XXX_DATA(520g4, 0, 0),
-	[BQ27530]   = BQ27XXX_DATA(530,   0, 0),
-	[BQ27531]   = BQ27XXX_DATA(531,   BQ27530, 0),
-	[BQ27541]   = BQ27XXX_DATA(541,   0, 0),
-	[BQ27542]   = BQ27XXX_DATA(542,   BQ27541, 0),
-	[BQ27546]   = BQ27XXX_DATA(546,   BQ27541, 0),
-	[BQ27742]   = BQ27XXX_DATA(742,   BQ27541, 0),
-	[BQ27545]   = BQ27XXX_DATA(545,   0, 0),
-	[BQ27421]   = BQ27XXX_DATA(421,   0, 0),
-	[BQ27425]   = BQ27XXX_DATA(425,   BQ27421, 0),
-	[BQ27441]   = BQ27XXX_DATA(441,   BQ27421, 0),
-	[BQ27621]   = BQ27XXX_DATA(621,   BQ27421, 0),
+	[BQ27000]   = BQ27XXX_DATA(000,   0, 0, 0),
+	[BQ27010]   = BQ27XXX_DATA(010,   0, 0, 0),
+	[BQ2750X]   = BQ27XXX_DATA(50x,   0, 0, 0),
+	[BQ2751X]   = BQ27XXX_DATA(51x,   0, 0, 0),
+	[BQ2752X]   = BQ27XXX_DATA(52x,   BQ2751X, 0, 0),
+	[BQ27500]   = BQ27XXX_DATA(500,   0,       0x04143672, 0),
+	[BQ27510G1] = BQ27XXX_DATA(510g1, 0, 0, 0),
+	[BQ27510G2] = BQ27XXX_DATA(510g2, 0, 0, 0),
+	[BQ27510G3] = BQ27XXX_DATA(510g3, 0, 0, 0),
+	[BQ27520G1] = BQ27XXX_DATA(520g1, 0, 0, 0),
+	[BQ27520G2] = BQ27XXX_DATA(520g2, 0, 0, 0),
+	[BQ27520G3] = BQ27XXX_DATA(520g3, 0, 0, 0),
+	[BQ27520G4] = BQ27XXX_DATA(520g4, 0, 0, 0),
+	[BQ27530]   = BQ27XXX_DATA(530,   0, 0, 0),
+	[BQ27531]   = BQ27XXX_DATA(531,   BQ27530, 0, 0),
+	[BQ27541]   = BQ27XXX_DATA(541,   0, 0, 0),
+	[BQ27542]   = BQ27XXX_DATA(542,   BQ27541, 0, 0),
+	[BQ27546]   = BQ27XXX_DATA(546,   BQ27541, 0, 0),
+	[BQ27742]   = BQ27XXX_DATA(742,   BQ27541, 0, 0),
+	[BQ27545]   = BQ27XXX_DATA(545,   0,       0x04143672, 0),
+	[BQ27421]   = BQ27XXX_DATA(421,   0,       0x80008000, 0),
+	[BQ27425]   = BQ27XXX_DATA(425,   BQ27421, 0x04143672, 0),
+	[BQ27441]   = BQ27XXX_DATA(441,   BQ27421, 0x80008000, 0),
+	[BQ27621]   = BQ27XXX_DATA(621,   BQ27421, 0x80008000, 0),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -832,13 +922,6 @@ static LIST_HEAD(bq27xxx_battery_devices);
 
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
@@ -871,12 +954,6 @@ static inline u16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
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
@@ -1912,8 +1989,13 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
 
-	di->regs = bq27xxx_chip_data[di->chip].regs;
-	di->opts = bq27xxx_chip_data[di->chip].opts;
+	di->regs       = bq27xxx_chip_data[di->chip].regs;
+	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
+	di->dm_regs    = bq27xxx_chip_data[di->chip].dm_regs;
+	di->opts       = bq27xxx_chip_data[di->chip].opts;
+	di->ram_chip = di->chip == BQ27421 ||
+		       di->chip == BQ27441 ||
+		       di->chip == BQ27621;
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
-- 
2.13.1
