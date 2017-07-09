From: Liam Breck <liam@networkimprov.net>
Subject: [RFC v1 4/6] power: supply: bq27xxx: Add chip data options for cfgupdate & ram-only
Date: Sat,  8 Jul 2017 19:16:58 -0700
Message-ID: <20170709021700.14354-5-liam@networkimprov.net>
References: <20170709021700.14354-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34685 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdGICRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jul 2017 22:17:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so8546812pge.1
        for <linux-pm@vger.kernel.org>; Sat, 08 Jul 2017 19:17:41 -0700 (PDT)
In-Reply-To: <20170709021700.14354-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Add BQ27XXX_O_CFGUP & _O_RAM for use in bq27xxx_chip_data[n].opts
Replace related uses of di->chip == BQ27nnn with (BQ27XXX_O_XYZ & di->opts)

No functional changes to the driver.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 22 +++++++++++-----------
 include/linux/power/bq27xxx_battery.h  |  1 -
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 0bd46fae..5d3893a9 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -871,6 +871,9 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #define bq27621_dm_regs 0
 #endif
 
+#define BQ27XXX_O_CFGUP  0x00000001
+#define BQ27XXX_O_RAM    0x00000002
+
 #define BQ27XXX_DATA(ref, act, key, opt) {	\
 	.opts = (opt),				\
 	.acts_like = act,			\
@@ -909,10 +912,10 @@ static struct {
 	[BQ27546]   = BQ27XXX_DATA(546,   BQ27541, 0, 0),
 	[BQ27742]   = BQ27XXX_DATA(742,   BQ27541, 0, 0),
 	[BQ27545]   = BQ27XXX_DATA(545,   0,       0x04143672, 0),
-	[BQ27421]   = BQ27XXX_DATA(421,   0,       0x80008000, 0),
-	[BQ27425]   = BQ27XXX_DATA(425,   BQ27421, 0x04143672, 0),
-	[BQ27441]   = BQ27XXX_DATA(441,   BQ27421, 0x80008000, 0),
-	[BQ27621]   = BQ27XXX_DATA(621,   BQ27421, 0x80008000, 0),
+	[BQ27421]   = BQ27XXX_DATA(421,   0,       0x80008000, BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
+	[BQ27425]   = BQ27XXX_DATA(425,   BQ27421, 0x04143672, BQ27XXX_O_CFGUP),
+	[BQ27441]   = BQ27XXX_DATA(441,   BQ27421, 0x80008000, BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
+	[BQ27621]   = BQ27XXX_DATA(621,   BQ27421, 0x80008000, BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -1196,9 +1199,9 @@ static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
 	}
 
 #ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
-	if (!di->ram_chip && !bq27xxx_dt_to_nvm) {
+	if (!(BQ27XXX_O_RAM & di->opts) && !bq27xxx_dt_to_nvm) {
 #else
-	if (!di->ram_chip) {
+	if (!(BQ27XXX_O_RAM & di->opts)) {
 #endif
 		/* devicetree and NVM differ; defer to NVM */
 		dev_warn(di->dev, "%s has %u; update to %u disallowed "
@@ -1266,7 +1269,7 @@ static inline int bq27xxx_battery_soft_reset(struct bq27xxx_device_info *di)
 static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
 					  struct bq27xxx_dm_buf *buf)
 {
-	bool cfgup = di->chip == BQ27421; /* assume related chips need cfgupdate */
+	bool cfgup = BQ27XXX_O_CFGUP & di->opts;
 	int ret;
 
 	if (!buf->dirty)
@@ -1365,7 +1368,7 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
 
 	bq27xxx_battery_seal(di);
 
-	if (updated && di->chip != BQ27421) { /* not a cfgupdate chip, so reset */
+	if (updated && !(BQ27XXX_O_CFGUP & di->opts)) {
 		bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
 		BQ27XXX_MSLEEP(300); /* reset time is not documented */
 	}
@@ -1993,9 +1996,6 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
 	di->dm_regs    = bq27xxx_chip_data[di->chip].dm_regs;
 	di->opts       = bq27xxx_chip_data[di->chip].opts;
-	di->ram_chip = di->chip == BQ27421 ||
-		       di->chip == BQ27441 ||
-		       di->chip == BQ27621;
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
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
2.13.1
