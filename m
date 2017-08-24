From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 4/5] power: supply: bq27xxx: Flag identical chip data when in debug mode
Date: Wed, 23 Aug 2017 20:36:16 -0700
Message-ID: <20170824033617.20840-5-liam@networkimprov.net>
References: <20170824033617.20840-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35842 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdHXDg5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 23:36:57 -0400
Received: by mail-pg0-f66.google.com with SMTP id m7so1961400pga.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2017 20:36:57 -0700 (PDT)
In-Reply-To: <20170824033617.20840-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

The driver has 13 unique register maps, several of which are shared
by multiple chips. When adding support for a new chip, it's easy to
add a duplicate map by mistake.

In debug mode we now scan bq27xxx_chip_data[n].regs/props/dm_regs for
duplicates.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 39 +++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index f2e55b90..3a6b9549 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -883,7 +883,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 	.props = ref##_props,			\
 	.props_size = ARRAY_SIZE(ref##_props) }
 
-static struct {
+static struct bq27xxx_chip_datum {
 	u32 opts;
 	u32 unseal_key;
 	u8 *regs;
@@ -917,6 +917,39 @@ static struct {
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 };
 
+static void __maybe_unused bq27xxx_battery_dbg_dupes(struct bq27xxx_device_info *di)
+{
+	static bool once = false;
+	const size_t max = ARRAY_SIZE(bq27xxx_chip_data);
+	const char * const msg = "bq27xxx_chip_data[%d].%s & [%d].%s are identical\n";
+	struct bq27xxx_chip_datum *a, *b;
+	int i, j;
+
+	if (once)
+		return;
+	once = true;
+
+	for (i = 1; i < max-1; i++) {
+		a = bq27xxx_chip_data + i;
+
+		for (j = i+1; j < max; j++) {
+			b = bq27xxx_chip_data + j;
+
+			if (a->regs != b->regs &&
+			    !memcmp(a->regs, b->regs, sizeof(bq27000_regs)))
+				dev_warn(di->dev, msg, i, "regs", j, "regs");
+
+			if (a->props != b->props && a->props_size == b->props_size &&
+			    !memcmp(a->props, b->props, a->props_size * sizeof(a->props[0])))
+				dev_warn(di->dev, msg, i, "props", j, "props");
+
+			if (a->dm_regs != b->dm_regs && a->dm_regs && b->dm_regs &&
+			    !memcmp(a->dm_regs, b->dm_regs, sizeof(bq27425_dm_regs)))
+				dev_warn(di->dev, msg, i, "dm_regs", j, "dm_regs");
+		}
+	}
+}
+
 static DEFINE_MUTEX(bq27xxx_list_lock);
 static LIST_HEAD(bq27xxx_battery_devices);
 
@@ -1974,6 +2007,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+#ifdef DEBUG
+	bq27xxx_battery_dbg_dupes(di);
+#endif
+
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
 
-- 
2.13.2
